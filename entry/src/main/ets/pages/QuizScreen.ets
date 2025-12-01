import { media } from '@kit.MediaKit';
import { audio } from '@kit.AudioKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { Question } from '../model/Question';
import { Score } from '../model/Score';
import { Questions } from '../viewmodel/Questions';
import { QuestionOptions } from '../components/QuestionOptions';
import { CustomButton } from '../components/CustomButton';
import { window } from '@kit.ArkUI';
import { AlertDialog } from '@kit.ArkUI';

const PROGRESS_TOTAL = 100;
const XP = 35;

@Component
export default struct QuizScreen {
  @Consume('pages') pages: NavPathStack;
  @Consume('scoreInfo') scoreInfo: Score;
  @State chosenCont: string = '';
  @State questionList: Question[] = [];
  @State currentQuestionIndex: number = 0;
  @State selectedIndex: number = -1;
  @State progressValue: number = 10;
  @State isShowCheckQuestionDialog: boolean = false;
  @State answerState: boolean = false;
  @State totalTime: number = 0;
  @State correctCount: number = 0;
  @State totalPoint: number = 0;
  @State currentQuestion: Question = {
    question: '',
    languageException: false,
    options: [],
  };
  private avPlayer?: media.AVPlayer;
  private timer: number = 0;
  private questions = new Questions();
  scroller: Scroller = new Scroller();
  @State timeLeft: number = 10;
  @State timerId: number = -1;
  @State message: string = ''
  @State topic: string = ''
  private uiContext: UIContext = this.getUIContext();

  dialogControllerConfirm: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: 'Time is out',
      content: 'Maybe you should be faster.',
      primaryButton: {
        value: 'Menu',
        background: Color.Red,
        fontColor: Color.White,
        action: () => {
          this.pages.pushPathByName('MainScreen', 0)
        }
      },
      secondaryButton: {
        value: 'Try Again',
        fontColor: Color.White,
        background: Color.Blue,
        action: () => {
          this.pages.pushPathByName('ContinentChooseScreen', 0)
        },
      }
    }),
    width: '100%',
    height: '100%',
    cornerRadius: 200,
    borderWidth: 2,
    borderStyle: BorderStyle.Solid,
    borderColor: Color.Red,
    backgroundBlurStyle: BlurStyle.NONE,
    backgroundColor: '#EABE7C',
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      dismissDialogAction.dismiss();
      this.pages.pushPathByName('MainScreen', 0)
    }
  })

  startTimer(): void {
    this.clearTimer();
    this.timeLeft = 10;
    this.timerId = setInterval(() => {
      this.timeLeft--;
      if (this.timeLeft <= 0) {
        this.timeUp();
      }
    }, 1000);
  }

  aboutToDisappear(): void {
    this.clearTimer();
    this.clearTimerLast();
  }

  aboutToAppear(): void {
    //Register custom font. Every custom language must be registered. Poor performance, can be improved by optimizing
    this.uiContext.getFont().registerFont({
      familyName: 'NotoSansDevanagari',
      familySrc: $rawfile('NotoSansDevanagari_VariableFont.ttf')
    })
  }

  initTimer() {
    this.timer = setInterval(() => {
      this.totalTime++;
    }, 1000)
  }

  clearTimer() {
    clearInterval(this.timer);
  }

  nextQuestion() {
    this.currentQuestionIndex++;
    this.selectedIndex = -1;
    this.currentQuestion = this.questionList[this.currentQuestionIndex];
    this.scroller.scrollEdge(Edge.Top)
    this.startTimer()
  }

  timeUp(): void {
    // If dev wants to use confirm button and taking chosen index as answer when time is up
    /*
    if(this.selectedIndex !== -1){
      this.isShowCheckQuestionDialog = true;
      this.progressValue =
        PROGRESS_TOTAL / (this.questionList.length) * (this.currentQuestionIndex + 1)

      if (this.currentQuestion.options[this.selectedIndex].isCorrect) {
        this.answerState = true;
        this.correctAnswer();
      } else {
        this.answerState = false;
        this.wrongAnswer();
      }
      return
    }*/
    this.clearTimerLast();
    // this.message = 'You didn`t answer in time.';
    this.dialogControllerConfirm.open()

  }



  clearTimerLast(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  setAVPlayerCallback(avPlayer: media.AVPlayer) {

    avPlayer.on('error', (err: BusinessError) => {
      avPlayer.reset();
    });

    avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
      switch (state) {
        case 'idle':
          avPlayer.release();
          break;
        case 'initialized':
          avPlayer.audioRendererInfo = {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0
          };
          avPlayer.prepare();
          break;
        case 'prepared':
          avPlayer.play();
          break;
        case 'playing':
          break;
        case 'paused':
          break;
        case 'completed':
          avPlayer.stop();
          break;
        case 'stopped':
          avPlayer.reset();
          break;
        case 'released':
          break;
        default:
          break;
      }
    });
  }

  async correctAnswer() {
    this.clearTimerLast();

    this.correctCount++;
    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context;
    const file = await context.resourceManager.getRawFd('correct_answer.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  async wrongAnswer() {
    this.clearTimerLast();

    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context
    const file = await context.resourceManager.getRawFd('wrong_answer.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  async quizComplete() {
    this.clearTimer();
    this.calcScore();
    this.pages.pop();
    this.avPlayer = await media.createAVPlayer();
    this.setAVPlayerCallback(this.avPlayer);
    const context = this.getUIContext().getHostContext() as Context
    const file = await context.resourceManager.getRawFd('quiz_complete.mp3');
    const avFileDesc: media.AVFileDescriptor = {
      fd: file.fd, offset: file.offset, length: file.length
    }
    if (this.avPlayer) {
      this.avPlayer.fdSrc = avFileDesc;
      this.avPlayer.play();
    }
  }

  calcScore() {
    const score: Score = {
      score: this.correctCount * XP,
      percent: Math.round(PROGRESS_TOTAL / this.questionList.length * this.correctCount),
    }
    this.scoreInfo = score;
  }

  @Builder
  QuestionCheck() {
    Column() {
      Row({ space: 4 }) {
        Image(this.answerState === true ? $r('app.media.correct') : $r('app.media.incorrect'))
          .width(18)
          .height(18);

        Text(this.answerState === true ? 'Excellent!' : 'Incorrect!')
          .fontSize(18)
          .fontColor(this.answerState === true ? '#58CC02' : '#FF4B4B')
          .fontWeight(FontWeight.Bold);
      }

      if (this.answerState === false) {
        Column() {
          Text(`${this.currentQuestion.options.filter((answer) => answer.isCorrect)[0].value}`)
            .fontColor('#58CC02')
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .fontWeight(FontWeight.Bold);
        }
      }
      CustomButton({
        text: 'Continue',
        isEnabled: true,
        type: this.answerState,
        onAction: () => {
          if (this.currentQuestionIndex >= this.questionList.length - 1) {
            this.isShowCheckQuestionDialog = false;
            this.quizComplete();
            this.pages.pushPathByName('ScoreScreen', '')
            return;
          }
          this.isShowCheckQuestionDialog = false;
          this.nextQuestion();

        }
      }).width('50%')
    }
    .width('100%')
    .backgroundColor(this.answerState === true ? '#D6FFB8' : '#FFDFE0')
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    NavDestination() {

      Row({ space: 6 }) {
        Text(`${this.timeLeft}s`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.timeLeft <= 3 ? '#FF4444' : '#FF6B35')
          .padding(3)
          .borderRadius(1)
      }
      .alignItems(VerticalAlign.Center)
      .width(60)
      .borderRadius(15)
      .backgroundColor(this.timeLeft <= 3 ? '#ffebee' : '#fff3e0')
      .justifyContent(FlexAlign.Center);

      Scroll(this.scroller) {
        Column({ space: 6 }) {

          Text(this.currentQuestion.question)
            .width('90%')
            .fontSize(18)
            .fontFamily(typeof this.currentQuestion.languageException === 'string' ?
              this.currentQuestion.languageException : undefined)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black);


          QuestionOptions({
            currentQuestion: this.currentQuestion,
            selectedIndex: this.selectedIndex,
            onAction: () => {
              this.isShowCheckQuestionDialog = true;
              this.progressValue =
                PROGRESS_TOTAL / (this.questionList.length) * (this.currentQuestionIndex + 1)

              if (this.currentQuestion.options[this.selectedIndex].isCorrect) {
                this.answerState = true;
                this.correctAnswer();
              } else {
                this.answerState = false;
                this.wrongAnswer();
              }
            }
          })

        }
        .padding({
          bottom: 24
        })
        .width('100%');
      }
      .scrollBar(BarState.Off)
      .padding({
        bottom: 12,
        top: 12
      })
      .height('100%')
      .bindSheet(this.isShowCheckQuestionDialog, this.QuestionCheck(), {
        height: 110,
        mode: SheetMode.OVERLAY,
        showClose: false,
        onWillDismiss: (() => {
          return false;
        })
      })
    }
    .onReady(cxt => {
      this.chosenCont = cxt.pathInfo.param as string
      // this.questions = new Questions()
      this.questionList = this.questions.callMethodByName(this.chosenCont)
      this.currentQuestion = this.questionList[this.currentQuestionIndex]
      this.initTimer()
      this.startTimer()
    })
    .backgroundColor('#F9F8F6')
    .hideBackButton(true)
  }
}
