import router from '@ohos.router'
import { MColor } from '../common/CommonConstants'
import RecommendViewModel, { AlbumsItem, AlbumInfoBean, AlbumInfo, SingBean } from '../models/RecommendModel'

@Entry
@Component
struct SongListPage {
  @State singItem: AlbumsItem = {
    id: 0,
    username: '',
    title: '',
    pic: ''
  }
  @State singList: AlbumInfo[] = []
  @State songMap: Record<string, string> = {}
  // @State url

  aboutToAppear() {
    const params: AlbumsItem = router.getParams() as AlbumsItem
    this.singItem = params

    RecommendViewModel.getAlbumInfoList(this.singItem.id)
      .then((res: AlbumInfoBean) => {
        this.singList = res.songs
        return res.songs
      }).then(result => {
      this.getSongUrl(result)
    })
  }

  getSongUrl(list: AlbumInfo[]) {
    let mid = ''
    for (let ele of list) {
      mid += `mid[]=${ele.mid}&`
    }
    RecommendViewModel.getSongUrlsList(mid)
      .then((res: SingBean) => {
        for (let item of this.singList) {
          item.url = res.map[item.mid]
        }
        this.songMap = res.map
      })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Row() {
      //   if (this.singItem.title) {
      //     Text(this.singItem.title)
      //       .fontColor('#fff')
      //   }
      // }
      // .justifyContent(FlexAlign.Center)
      // .width('100%')
      // .height(40)
      // .zIndex(1)

      List() {
        ListItem() {
          Column() {
            if (this.singItem.pic) {
              Image(this.singItem.pic)
                .width('100%')
                .height(260)
                .margin({ bottom: 30 })
            }

            if (this.singList.length) {
              ForEach(this.singList, (item: AlbumInfo) => {
                Column({ space: 10 }) {
                  Text(item.name).fontSize(14).fontColor('#fff')
                  Text(`${item.singer} - ${item.album}`).fontSize(14).fontColor('#656565')
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .padding({ left: 20, top: 10, right: 20, bottom: 10 })
                .onClick(() => {
                  this.singList.unshift(item)
                  router.pushUrl({
                    url: 'pages/PlayerPage',
                    params: { list: this.singList }
                  })
                })
              })
            }
          }
          .width('100%')
          .backgroundColor(MColor.PRIMARY_BACKGROUND)
        }
      }
      .backgroundColor(MColor.PRIMARY_BACKGROUND)
    }
  }

  pageTransition() {
    PageTransitionExit({ duration: 0, curve: Curve.Smooth })
      .slide(SlideEffect.Bottom);
  }
}