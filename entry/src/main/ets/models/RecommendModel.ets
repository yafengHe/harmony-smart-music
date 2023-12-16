import { httpRequestGet } from '../utils/HttpUtil';
import { CommonConstant as Const } from '../common/CommonConstants';
import { ResponseResult } from '.';

export class SliderItem {
  id: string
  pic: string
  link: string
}

export class AlbumsItem {
  id: number
  username: string
  title: string
  pic: string
}

export class RecommendBean {
  sliders: SliderItem[]
  albums: AlbumsItem[]
}

export class AlbumInfo {
  album: string
  duration: number
  id: number
  mid: string
  name: string
  pic: string
  singer: string
  url: string
}

export class AlbumInfoBean {
  songs: AlbumInfo[]
}

class RecommendViewModel {
  getNewsTypeList(): Promise<RecommendBean> {
    return new Promise((resolve: Function) => {
      let url = `http://192.168.3.176:9002/api/getRecommend`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === 0) {
          resolve(data.result);
        } else {
          resolve(new RecommendBean());
        }
      }).catch(() => {
        resolve(new RecommendBean());
      });
    });
  }

  getAlbumInfoList(id: number): Promise<AlbumInfoBean> {
    return new Promise((resolve: Function) => {
      let url = `http://192.168.3.176:9002/api/getAlbum?id=${id}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === 0) {
          resolve(data.result);
        } else {
          resolve(new AlbumInfoBean());
        }
      }).catch(() => {
        resolve(new AlbumInfoBean());
      });
    });
  }

  getSongUrlsList(): Promise<Map<string, string>> {
    return new Promise((resolve: Function) => {
      let url = `http://192.168.3.176:9002/api/getSongsUrl`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === 0) {
          resolve(data.result);
        } else {
          resolve({});
        }
      }).catch(() => {
        resolve({});
      });
    });
  }
}

let recommendViewModel = new RecommendViewModel();

export default recommendViewModel as RecommendViewModel;

