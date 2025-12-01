import { CustomButton } from '../components/CustomButton';
import { Score } from "../model/Score";
import { storeScore } from '../utils/ScoreStorage';
import { emitter } from '@kit.BasicServicesKit';

@Component
export default struct ScoreScreen {
  @Consume('scoreInfo') scoreInfo: Score;
  @Consume('pages') pages: NavPathStack;
  @Consume('totalXp') totalXp: number;

  build() {
    NavDestination() {

      Column({ space: 8 }) {

        Image(this.scoreInfo.percent <= 25 ?
          $r('app.media.low_score_img') :
          this.scoreInfo.percent <= 75 ? $r('app.media.mid_score_img') : $r('app.media.high_score_img')
        ).width(70)
        Text('Quiz Completed!')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Black)

        Column() {
          Text(`Score: ${this.scoreInfo.score}`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Green)
            .margin({ bottom: 6 })


          Text(`Percent: ${this.scoreInfo.percent}%`)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Blue)
            .margin({ bottom: 6 })
        }
        .height(60)
        .width('70%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .padding(10)
        .backgroundColor(Color.White)
        .border({ width: 1, color: Color.Black })
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: '#999999',
          offsetX: 0,
          offsetY: 4
        })

        CustomButton({
          text: 'Continue',
          isEnabled: true,
          type: true,
          onAction: () => {
            // async () => {
              storeScore(this.getUIContext().getHostContext() as Context, this.scoreInfo.score, this.scoreInfo.percent);
              emitter.emit({ eventId: 1 });
            // }
              this.pages.pushPathByName('MainScreen', 0)
          }
        }).width('50%')
          .margin({ top: -7 })

      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('%100')
      .height('100%')

    }
    .backgroundColor(Color.White)
    .hideBackButton(true)
    .onBackPressed(() => {
      storeScore(this.getUIContext().getHostContext() as Context, this.scoreInfo.score, this.scoreInfo.percent);
      emitter.emit({ eventId: 1 });
      this.pages.pushPathByName('MainScreen', 0)
      return true
    })
  }
}