import { getLast7Days, resetToday } from '../utils/ScoreStorage';
import emitter from '@ohos.events.emitter';
import { CustomText } from '../components/CustomText';

@Component
export default struct HowToScreen {
  @Consume('pages') pages: NavPathStack;


  build() {
    NavDestination() {
      Column() {
        CustomText({text:'-Click Play'})
        CustomText({text:'-Select a category\n Continent based languages'})
        CustomText({text:'-You will see different languages written'})
        CustomText({text:'-Find the language'})
        CustomText({text:'-Every question has 4 options and only one answer'})

        Button() {
          Text('Back')
        }
        .onClick(() => {
          this.pages.pushPathByName('MainScreen', 0)
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