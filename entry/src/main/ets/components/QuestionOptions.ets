import { Option, Question } from '../model/Question';

@Component
export struct QuestionOptions {
  @Prop @Watch('currQuestion') currentQuestion: Question;
  @Link selectedIndex: number;
  onAction?: () => void;


  build() {
    Column({ space: 12 }){
      ForEach(this.currentQuestion.options, (item: Option, index) => {
        Button(item.value).onClick(() => {
          this.selectedIndex = index
          if (this.onAction) {
            this.onAction();
          }
        })
          .fontColor(Color.Black)
          .borderWidth(2)
          .type(ButtonType.Normal)
          .borderRadius(12)
          .borderColor(this.selectedIndex === index ? '#1899D6' : '#777777')
          .width(150)
          .clickEffect({
            level: ClickEffectLevel.HEAVY
          })
          .backgroundColor(this.selectedIndex === index ? '#63C9F9' : '#ECE4B7');

      }, (item: string, index: number) => item)
    }

  }

  currQuestion(changedPropertyName: string) {
    if (this.currentQuestion) {
      console.info(`Question loaded`)
    }
  }
}