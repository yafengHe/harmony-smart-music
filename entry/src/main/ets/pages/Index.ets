import { MColor } from '../common/CommonConstants'
import { ToolBar } from '../models'
import { FindPage } from './FindPage'
import { MyPage } from './MyPage'

@Entry
@Component
struct Index {
  @State activeIndex: number = 0
  toolBars: ToolBar[] = [
    { icon: $r('app.media.ic_public_home'), label: '发现' },
    { icon: $r('app.media.ic_public_contacts'), label: '我的' },
  ]

  @Builder TabBarBuilder(item: ToolBar, index: number) {
    Column({ space: 4 }) {
      Image(item.icon)
        .width(24)
        .aspectRatio(1)
        .fillColor(this.activeIndex === index ? MColor.PRIMARY : MColor.FORM_BORDER)
      Text(item.label)
        .fontColor(this.activeIndex === index ? MColor.PRIMARY : MColor.FORM_BORDER)
    }
  }

  build() {
    Tabs({ index: this.activeIndex }) {
      ForEach(this.toolBars, (item: ToolBar, index: number) => {
        TabContent(){
          if (index === 0) {
            FindPage()
          } else {
            MyPage()
          }
        }.tabBar(this.TabBarBuilder(item, index))
      }, (item: ToolBar) => JSON.stringify(item))
    }
    .barPosition(BarPosition.End)
    .onChange(index => this.activeIndex = index)
    .backgroundColor(MColor.PRIMARY_BACKGROUND)
  }
}