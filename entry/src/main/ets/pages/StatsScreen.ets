import { getLast7Days, resetToday } from '../utils/ScoreStorage';
import emitter from '@ohos.events.emitter';

@Component
export default struct StatsScreen {
  @Consume('pages') pages: NavPathStack;
  @Consume scoreData: number[] = [0, 0, 0, 0, 0, 0];
  @Consume percentData: number[] = [0, 0, 0, 0, 0, 0];
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private context2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private ctx: CanvasRenderingContext2D | null = null;
  private ctx2: CanvasRenderingContext2D | null = null;
  private screenWidth: number = 0;
  private screenHeight: number = 0;

  private drawGraph(cts: CanvasRenderingContext2D | null, takenContext: CanvasRenderingContext2D, takenData: number[]) {
    if (!cts) {
      return;
    }
    //The context size of swiper element becomes smaller for subsequent items, so we used global variables.
    const w: number = this.screenWidth;
    const h: number = this.screenHeight;
    takenContext.clearRect(0, 0, w, h);

    // Scale data
    const maxVal: number = Math.max(...takenData);
    const stepX: number = (w - 65) / (takenData.length - 1);

    // Draw axes + labels
    for (let i = 0; i < 4; i++) {
      if (i === 0) {
        takenContext.strokeStyle = '#DD6031';
      } else {
        takenContext.strokeStyle = '#EABE7C';
      }

      const y = h - 30 - i * 20;

      // draw line
      takenContext.beginPath();
      takenContext.moveTo(15, y); // start a bit to the right (leave room for labels)
      takenContext.lineTo(w - 15, y);
      takenContext.stroke();

      // compute value for this line (relative to maxVal)
      const value = Math.round((i / 3) * maxVal);

      // draw text
      takenContext.fillStyle = '#4f351c';
      takenContext.font = '12px sans-serif';
      takenContext.textAlign = 'right';
      takenContext.textBaseline = 'middle';
      takenContext.fillText(value.toString(), 15, y);
    }


    // Plot line
    takenContext.strokeStyle = '#4f351c';
    takenContext.lineWidth = 2;
    takenContext.beginPath();
    takenData.forEach((v: number, i: number) => {
      const x = 25 + i * stepX;
      const y = maxVal > 0 ? h - 30 - (v / maxVal) * (h - 60) : h - 30;

      if (i === 0) {
        takenContext.moveTo(x, y);
      } else {
        takenContext.lineTo(x, y);
      }
    });
    takenContext.stroke();

    // Points
    takenContext.fillStyle = '#713105';
    takenData.forEach((v: number, i: number) => {
      const x = 25 + i * stepX;
      const y = maxVal > 0 ? h - 30 - (v / maxVal) * (h - 60) : h - 30;
      takenContext.beginPath();
      takenContext.arc(x, y, 3, 0, Math.PI * 2);
      takenContext.fill();
    });

  }

  async aboutToAppear() {
    this.scoreData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'score');
    this.percentData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'percent');
    if (this.ctx) {
      this.screenWidth = this.ctx.width
      this.screenHeight = this.ctx.height
      this.drawGraph(this.ctx, this.context, this.scoreData);
    }
    if (this.ctx2) {
      this.drawGraph(this.ctx2, this.context2, this.percentData);
    }
    emitter.on({ eventId: 1 }, async () => {
      this.scoreData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'score');
      this.percentData = await getLast7Days(this.getUIContext().getHostContext() as Context, 'percent');
      this.drawGraph(this.ctx, this.context, this.scoreData);
      this.drawGraph(this.ctx2, this.context2, this.percentData);
    });
  }

  build() {
    NavDestination() {
      Column() {
        Swiper() {
          Column() {
            Text((this.percentData[this.percentData.length - 1].toFixed(1) ?? 0) + '\nAverage Percent Correction')
              .fontSize(20)
              .fontColor('#311E10')
              .height('30%')
            Canvas(this.context2)
              .width('90%')
              .height('51%')
              .onAppear(() => {
                this.ctx2 = this.context2
              })
          }

          Column() {
            Text((this.scoreData[this.scoreData.length - 1].toFixed(1) ?? 0) + '\nAverage Points')
              .fontSize(20)
              .fontColor('#311E10')
              .height('30%')
            Canvas(this.context)
              .width('90%')
              .height('51%')
              .onAppear(() => {
                this.ctx = this.context
              }
              )
          }
        }
        .indicator(new DotIndicator()
          .color('#DD6031')
          .selectedColor('#DD6031'))
        .loop(true)


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
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(8)
      .width('%100')
      .height('100%')
    }
    .backgroundColor('#F9F8F6')
    .hideBackButton(true)
  }
}