import { getLast7Days, resetToday } from '../utils/ScoreStorage';
import emitter from '@ohos.events.emitter';

@Component
export default struct MainScreen {
  @Consume('pages') pages: NavPathStack;

  async aboutToAppear() {
    // Resetting today's data for testing
    // await resetToday(this.getUIContext().getHostContext() as Context)
    // this.scoreData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'score');
    // this.percentData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'percent');
    // if (this.ctx) {
    //   this.screenWidth = this.ctx.width
    //   this.screenHeight = this.ctx.height
    //   this.drawGraph(this.ctx, this.context, this.scoreData);
    // }
    // if (this.ctx2) {
    //   this.drawGraph(this.ctx2, this.context2, this.percentData);
    // }
    // emitter.on({ eventId: 1 }, async () => {
    //   this.scoreData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'score');
    //   this.percentData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'percent');
    //   this.drawGraph(this.ctx, this.context, this.scoreData);
    //   this.drawGraph(this.ctx2, this.context2, this.percentData);
    // });
  }

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
      .width('%100')
      .height('100%')
    }
    .backgroundColor('#F9F8F6')
    .hideBackButton(true)
  }
}