import { Option, Question } from '../model/Question';

@Component
export struct QuestionOptions {
  @Prop @Watch('currQuestion') currentQuestion: Question;
  @Link selectedIndex: number;
  @Prop isAnswered: boolean = false;
  onAction?: () => void;

  build() {
    Column({ space: 12 }){
      ForEach(this.currentQuestion.options, (item: Option, index) => {
        Button(item.value).onClick(() => {
          if (this.isAnswered) {
            return;
          }
          this.selectedIndex = index
          if (this.onAction) {
            this.onAction();
          }
        })
          .fontColor(Color.Black)
          .borderWidth(2)
          .type(ButtonType.Normal)
          .borderRadius(12)
          .borderColor(this.selectedIndex === index ? $r('app.color.color_option_selected_border') : $r('app.color.color_option_border'))
          .width(150)
          .clickEffect({
            level: ClickEffectLevel.HEAVY
          })
          .opacity(this.isAnswered && this.selectedIndex !== index ? 0.5 : 1.0)
          .backgroundColor(this.selectedIndex === index ? $r('app.color.color_option_selected_bg') : $r('app.color.color_option_bg'));

      }, (item: Option, index: number) => item.value)
    }
  }

  currQuestion(changedPropertyName: string) {
    if (this.currentQuestion) {
      console.info(`Question loaded`)
    }
  }
}
