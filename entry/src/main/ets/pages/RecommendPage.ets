import router from '@ohos.router'
import { MColor } from '../common/CommonConstants'
import RecommendViewModel, { AlbumsItem, RecommendBean, SliderItem } from '../models/RecommendModel'

@Component
export struct RecommendPage {
  private swiperController: SwiperController = new SwiperController()
  @State sliderList: SliderItem[] = []
  @State albumList: AlbumsItem[] = []

  aboutToAppear() {
    RecommendViewModel.getNewsTypeList().then((res: RecommendBean) => {
      this.sliderList = res.sliders
      this.albumList = res?.albums || []
    })
  }

  @Builder RecommendItem(item: AlbumsItem) {
    Row({ space: 10 }) {
      Image(item.pic)
        .width(60)
        .aspectRatio(1)
      Column({ space: 10 }) {
        Text(item.username)
          .fontColor(MColor.DEFAULT_WHITE)
        Text(item.title)
          .fontColor(MColor.BACKGROUND_COLOR)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(60)
    .margin({ bottom: 15 })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/SongListPage',
        params: item
      })
    })
  }

  build() {
    Scroll() {
      Column() {
        if (this.sliderList.length) {
          Swiper(this.swiperController) {
            ForEach(this.sliderList, (item: SliderItem) => {
              Image(item.pic)
                .width('100%')
                .height(150)
            }, item => item.id)
          }
          .cachedCount(2)
          .index(1)
          .autoPlay(true)
          .interval(4000)
          .indicator(true)
          .loop(true)
          .duration(1000)
          .itemSpace(0)
          .curve(Curve.Linear)
          .onChange((index: number) => {
            console.info(index.toString())
          })
        }
        Row() {
          Text('歌单推荐')
            .fontSize(16)
            .fontColor(MColor.PRIMARY)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(40)
        .margin({ top: 20 })
        .justifyContent(FlexAlign.Center)

        if (this.albumList.length) {
          ForEach(this.albumList, (item: AlbumsItem) => {
            this.RecommendItem(item)
          })
        }
      }
      .padding({ bottom: 70 })
      .width('100%')
    }
  }
}
