import router from '@ohos.router';
import { MColor } from '../common/CommonConstants';
import { AlbumInfo } from '../models/RecommendModel';
import image from "@ohos.multimedia.image";
import effectKit from '@ohos.effectKit';

@Entry
@Component
struct PlayerPage {
  @State message: string = 'Hello World'
  @State songList: AlbumInfo[] = router.getParams()['list'] as AlbumInfo[]
  private swiperController: SwiperController = new SwiperController()

  setImageFilter() {
    const color = new ArrayBuffer(96);
    let opts: image.InitializationOptions = {
      editable: true,
      pixelFormat: 3,
      size: {
        height: 4,
        width: 6
      }
    };
    image.createPixelMap(color, opts).then((pixelMap) => {
      let radius = 5;
      let headFilter = effectKit.createEffect(pixelMap);
      if (headFilter != null) {
        headFilter.blur(radius);
      }
    })
  }

  @Styles
  fullScreen() {
    .width('100%')
    .height('100%')
  }

  @Builder
  PlayBuilder(item: AlbumInfo) {
    Column() {

    }
    .fullScreen()
    .blur(20)
    .backdropBlur(20)
    .opacity(0.6)
    .backgroundImage(item.pic)
    .backgroundImageSize(ImageSize.Cover)
  }

  build() {
    if (this.songList.length) {
      Swiper(this.swiperController) {
        ForEach(this.songList, (item: AlbumInfo) => {
          this.PlayBuilder(item)
        }, item => item.id)
      }
      .cachedCount(2)
      .index(1)
      .autoPlay(false)
      .indicator(false)
      .loop(true)
      .vertical(true)
      .itemSpace(0)
      .curve(Curve.Linear)
      .effectMode(EdgeEffect.Fade)
      .onChange((index: number) => {
        console.info(index.toString())
      })
    }
    // Column(){
    //   if (this.singItem.name) {
    //     Text(this.singItem.name).fontSize(16).fontColor('#fff')
    //   }
    // }
    // .width('100%')
    // .height('100%')
    // .backgroundColor(MColor.PRIMARY_BACKGROUND)
  }

  pageTransition() {
    PageTransitionEnter({ duration: 600, curve: Curve.Smooth })
      .slide(SlideEffect.Bottom);
    PageTransitionExit({ duration: 600, curve: Curve.Smooth })
      .slide(SlideEffect.Bottom);
  }
}