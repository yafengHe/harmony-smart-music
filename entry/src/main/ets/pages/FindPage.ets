import { MColor } from '../common/CommonConstants'
import { FindBar } from '../models'
import { RankPage } from './RankPage'
import { RecommendPage } from './RecommendPage'
import { SearchPage } from './SearchPage'
import { SingerPage } from './SingerPage'

@Component
export struct FindPage {
  @State findActiveIndex: number = 0
  findPageBar: FindBar[] = [
    { id: 1, label: '推荐' },
    { id: 2, label: '歌手' },
    { id: 3, label: '排行' },
    { id: 4, label: '搜索' },
  ]

  @Builder TabBarBuilder(item: FindBar, index: number) {
    Column() {
      Text(item.label)
        .fontColor(this.findActiveIndex === index ? MColor.PRIMARY : MColor.FORM_BORDER)
        .border({ width: { bottom: this.findActiveIndex === index ? 2 : 0 }, color: this.findActiveIndex === index ? MColor.PRIMARY : MColor.FORM_BORDER })
        .padding({bottom: 8})
        .fontWeight(this.findActiveIndex === index ? 700 : 300)
    }
  }

  build() {
    Column() {
      FindHeader()
      Tabs({ index: this.findActiveIndex }) {
        ForEach(this.findPageBar, (item: FindBar, index: number) => {
          TabContent() {
            if (index === 0) {
              RecommendPage()
            } else if (index === 1) {
              SingerPage()
            } else if (index === 2) {
              RankPage()
            } else if (index === 3) {
              SearchPage()
            }
          }
          .tabBar(this.TabBarBuilder(item, index))
        }, (item: FindBar) => item.id.toString())
      }
      .onChange(index => this.findActiveIndex = index)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct FindHeader {
  build() {
    Row() {
      Text('Smart Music')
        .fontSize(16)
        .fontColor(MColor.PRIMARY)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height(40)
    .justifyContent(FlexAlign.Center)
  }
}