@Component
export struct CustomText {
  @Prop text: string = '';

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#311E10')
        .margin({ bottom: 6 })
    }
    // .width('100%')
    // .height(60)
  }
}