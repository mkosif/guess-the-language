import { ComponentContent, LengthMetrics } from '@kit.ArkUI';
import { UIContext, CircleShape } from '@kit.ArkUI';
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';

@Builder
function buildText() {
  Column() {
    Text('Category')
      .fontSize('60px')
      .fontWeight(FontWeight.Bold)
      .fontColor('#311E10')
  }.margin(0)
}

@Component
export default struct ContinentChooseScreen {
  @Consume('pages') pages: NavPathStack;
  @State continents: Array<string> = ['All', 'Asia', 'Europe', 'Africa', 'America'];
  @Provide('chosenCont') chosenCont: string = 'All';
  private watchSize: string = '466px';
  private listSize: string = '414px';
  context: UIContext = this.getUIContext();
  tabBar1: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(buildText));

  @Builder
  listContinents() {
    Stack() {
      Column() {
      }
      .justifyContent(FlexAlign.Center)
      .width(this.watchSize)
      .height(this.watchSize)
      .clipShape(new CircleShape({ width: '100%', height: '100%' }))
      .backgroundColor(Color.White)

      ArcList({ initialIndex: 0, header: this.tabBar1 }) {
        ForEach(this.continents, (item: number, index: number) => {
          ArcListItem() {
            Button('' + item, { type: ButtonType.Capsule })
              .width(this.listSize)
              .height('100px')
              .fontSize('40px')
              .focusable(true)
              .focusOnTouch(true)
              .backgroundColor('#EABE7C')
              .borderWidth(2)
              .borderRadius(12)
              .borderColor('#311E10')
              .onClick(() => {
                this.chosenCont = item.toString()
                this.pages.pushPathByName('QuizScreen', this.chosenCont)
              })
          }.align(Alignment.Center)
        }, (item: number, index: number) => (item + index).toString())

        ArcListItem(){
          Button('Back' , { type: ButtonType.Capsule })
            .width('212px')
            .height('100px')
            .fontSize('40px')
            .focusable(true)
            .focusOnTouch(true)
            .backgroundColor('#311E10')
            .borderWidth(2)
            .borderRadius(12)
            .borderColor('#EABE7C')
            .onClick(() => {
              this.pages.pushPathByName('MainScreen', this.chosenCont)
            })
        }
      }
      .space(LengthMetrics.px(10))
      .borderRadius(this.watchSize)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)

    }
    .align(Alignment.Center)
    .width(this.watchSize)
    .height(this.watchSize)
    .border({ color: Color.Black, width: 1 })
    .borderRadius(this.watchSize)
  }

  build() {
    NavDestination() {
      Column() {
        this.listContinents()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .hideBackButton(true)
    .backgroundColor(Color.White)
  }

  // @Builder
  // listItemComponent(listItem: string, index: number) {
  //   Row() {
  //     Text(listItem.toString())
  //       .margin({ left: 10 })
  //       .fontColor(Color.Black)
  //   }
  //   .onClick(() => {
  //     this.chosenCont = listItem.toString()
  //     console.log('Chosen continents is: '+ this.chosenCont.toString())
  //     this.pages.pushPathByName('QuizScreen', this.chosenCont)
  //   })
  //   .width('100%')
  //   .padding(10)
  //   .background('#ECE4B7')
  //   .border({
  //     width: 1,
  //     color: '#EABE7C',
  //     radius: 6,
  //     style: BorderStyle.Solid
  //   })
  //   .justifyContent(FlexAlign.SpaceBetween)
  // }

  // @Builder
  // listContinents() {
  //   List({ space: 12, initialIndex: 0 }) {
  //     ForEach(this.continents, (item: string, index?: number) => {
  //       ListItem() {
  //         if (index != undefined) {
  //           this.listItemComponent(item, index)
  //         }
  //       }
  //     }, (item: string) => item.toString())
  //   }
  //   .backgroundColor('#F9F8F6')
  //   .margin(20)
  //   .height('60%')
  //   .scrollBar(BarState.Off)
  //   .edgeEffect(EdgeEffect.Spring)
  // }
}
