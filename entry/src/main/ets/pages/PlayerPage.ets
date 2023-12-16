import router from '@ohos.router';
import { MColor } from '../common/CommonConstants';
import { AlbumInfo } from '../models/RecommendModel';
@Entry
@Component
struct PlayerPage {
  @State message: string = 'Hello World'

  @State singItem: AlbumInfo = new AlbumInfo()

  aboutToAppear() {
    const params = router.getParams()
    this.singItem = params as AlbumInfo
  }

  build() {
    Column(){
      if (this.singItem.name) {
        Text(this.singItem.name).fontSize(16).fontColor('#fff')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MColor.PRIMARY_BACKGROUND)
  }

  pageTransition() {
    PageTransitionEnter({ duration: 600, curve: Curve.Smooth })
      .slide(SlideEffect.Bottom);
    PageTransitionExit({ duration: 600, curve: Curve.Smooth })
      .slide(SlideEffect.Bottom);
  }
}