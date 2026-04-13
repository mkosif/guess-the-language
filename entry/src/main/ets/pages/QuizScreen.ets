import { Question } from '../model/Question';
import { Score } from '../model/Score';
import { loadContinentQuestions } from '../utils/QuestionLoader';
import { QuestionOptions } from '../components/QuestionOptions';
import { CustomButton } from '../components/CustomButton';
import { AlertDialog } from '@kit.ArkUI';
import { playAudio } from '../components/playAudio'

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
  @State isShowCheckQuestionDialog: boolean = false;
  @State isAnswered: boolean = false;
  @State answerState: boolean = false;
  @State correctCount: number = 0;
  @State currentQuestion: Question = {
    question: '',
    languageException: false,
    options: []
  };
  scroller: Scroller = new Scroller();
  @State timeLeft: number = 10;
  private questionTimerId: number = -1;
  private uiContext: UIContext = this.getUIContext();
  dialogControllerConfirm: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: $r('app.string.dialog_timeout_title'),
      content: $r('app.string.dialog_timeout_content'),
      primaryButton: {
        value: $r('app.string.btn_menu'),
        background: Color.Red,
        fontColor: Color.White,
        action: () => {
          this.pages.clear();
          this.pages.pushPathByName('MainScreen', 0)
        }
      },
      secondaryButton: {
        value: $r('app.string.btn_try_again'),
        fontColor: Color.White,
        background: Color.Blue,
        action: () => {
          this.pages.clear();
          this.pages.pushPathByName('ContinentChooseScreen', 0)
        }
      }
    }),
    width: '100%',
    height: '100%',
    cornerRadius: 200,
    borderWidth: 2,
    borderStyle: BorderStyle.Solid,
    borderColor: Color.Red,
    backgroundBlurStyle: BlurStyle.NONE,
    backgroundColor: $r('app.color.color_gold'),
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      dismissDialogAction.dismiss();
      this.pages.clear();
      this.pages.pushPathByName('MainScreen', 0)
    }
  })

  startTimer(): void {
    this.clearQuestionTimer();
    this.timeLeft = 10;
    this.questionTimerId = setInterval(() => {
      this.timeLeft--;
      if (this.timeLeft <= 0) {
        this.timeUp();
      }
    }, 1000);
  }

  aboutToDisappear(): void {
    this.clearQuestionTimer();
  }

  aboutToAppear(): void {
    //Register custom font. Every custom language must be registered. Poor performance, can be improved by optimizing
    this.uiContext.getFont().registerFont({
      familyName: 'NotoSansDevanagari',
      familySrc: $rawfile('NotoSansDevanagari_VariableFont.ttf')
    })
  }

  clearQuestionTimer(): void {
    if (this.questionTimerId !== -1) {
      clearInterval(this.questionTimerId);
      this.questionTimerId = -1;
    }
  }

  nextQuestion() {
    this.currentQuestionIndex++;
    this.selectedIndex = -1;
    this.isAnswered = false;
    this.currentQuestion = this.questionList[this.currentQuestionIndex];
    this.scroller.scrollEdge(Edge.Top)
    this.startTimer()
  }

  timeUp(): void {
    this.clearQuestionTimer();
    this.dialogControllerConfirm.open()
  }

  async correctAnswer() {
    this.clearQuestionTimer();
    this.isAnswered = true;
    this.correctCount++;
    const context = this.getUIContext().getHostContext() as Context;
    playAudio('correct_answer.mp3', context)
  }

  async wrongAnswer() {
    this.clearQuestionTimer();
    this.isAnswered = true;
    const context = this.getUIContext().getHostContext() as Context
    playAudio('wrong_answer.mp3', context)
  }

  async quizComplete() {
    this.clearQuestionTimer();
    this.calcScore();
    this.pages.pop();
    const context = this.getUIContext().getHostContext() as Context
    playAudio('quiz_complete.mp3', context)
  }

  calcScore() {
    const score: Score = {
      score: this.correctCount * XP,
      percent: Math.round(PROGRESS_TOTAL / this.questionList.length * this.correctCount)
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

        Text(this.answerState === true ? $r('app.string.answer_correct') : $r('app.string.answer_wrong'))
          .fontSize(18)
          .fontColor(this.answerState === true ? $r('app.color.color_correct') : $r('app.color.color_wrong'))
          .fontWeight(FontWeight.Bold);
      }

      if (this.answerState === false) {
        Text(`${this.currentQuestion.options.filter((answer) => answer.isCorrect)[0].value}`)
          .fontColor($r('app.color.color_correct'))
          .fontSize(18)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bold);
      }
      CustomButton({
        text: $r('app.string.btn_continue'),
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
    .backgroundColor(this.answerState === true ? $r('app.color.color_correct_bg') : $r('app.color.color_wrong_bg'))
    .height('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    NavDestination() {

      Row({ space: 8 }) {
        Text(`${this.timeLeft}s`)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.timeLeft <= 3 ? $r('app.color.color_timer_urgent') : $r('app.color.color_timer_normal'))
          .padding(3)
          .borderRadius(1)

        Text(`${this.currentQuestionIndex + 1}/${this.questionList.length}`)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.color_primary'))
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 8, right: 8 })
      .borderRadius(15)
      .backgroundColor(this.timeLeft <= 3 ? $r('app.color.color_timer_bg_urgent') : $r('app.color.color_timer_bg_normal'))
      .justifyContent(FlexAlign.SpaceBetween);

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
            isAnswered: this.isAnswered,
            onAction: () => {
              this.isShowCheckQuestionDialog = true;
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
      const context = this.getUIContext().getHostContext() as Context;
      this.questionList = loadContinentQuestions(context, this.chosenCont)
      if (this.questionList.length === 0) {
        this.pages.clear();
        this.pages.pushPathByName('MainScreen', 0)
        return;
      }
      this.currentQuestion = this.questionList[this.currentQuestionIndex]
      this.isAnswered = false;
      this.startTimer()
    })
    .backgroundColor($r('app.color.color_background'))
    .hideBackButton(true)
  }
}
