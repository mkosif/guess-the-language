import { getLast7Days, resetToday } from '../utils/ScoreStorage';
import emitter from '@ohos.events.emitter';

@Component
export default struct MainScreen {
  @Consume('pages') pages: NavPathStack;
  

  build() {
    NavDestination() {
      Column() {
        Text(`Language Guess`)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#311E10')
          .margin({ bottom: 6 })

        Button() {
          Text('Play')
        }
        .onClick(() => {
          this.pages.pushPathByName('ContinentChooseScreen', 0)
        })
        .alignSelf(ItemAlign.Center)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .width(80)
        .height(40)
        .borderRadius(200)
        .backgroundColor('#311E10')
        .borderWidth(2)
        .borderColor('#EABE7C')
        .shadow({
          offsetX: 1,
          offsetY: 1,
          color: Color.Black,
          radius: 10
        })

        Button() {
          Text('Stats')
        }
        .onClick(() => {
          this.pages.pushPathByName('StatsScreen', 0)
        })
        .alignSelf(ItemAlign.Center)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .width(80)
        .height(40)
        .borderRadius(200)
        .backgroundColor('#311E10')
        .borderWidth(2)
        .borderColor('#EABE7C')
        .shadow({
          offsetX: 1,
          offsetY: 1,
          color: Color.Black,
          radius: 10
        })

        Button() {
          Text('How to Play?')
        }
        .onClick(() => {
          this.pages.pushPathByName('HowToScreen', 0)
        })
        .alignSelf(ItemAlign.Center)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .width(80)
        .height(40)
        .borderRadius(200)
        .backgroundColor('#311E10')
        .borderWidth(2)
        .borderColor('#EABE7C')
        .shadow({
          offsetX: 1,
          offsetY: 1,
          color: Color.Black,
          radius: 10
        })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)
      .padding(15)
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#F9F8F6')
    .hideBackButton(true)
  }
}