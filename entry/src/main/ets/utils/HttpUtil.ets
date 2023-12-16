import http from '@ohos.net.http';
import { ResponseResult } from '../models';
import { CommonConstant as Const, ContentType } from '../common/CommonConstants';

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: Const.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: Const.HTTP_READ_TIMEOUT,
    extraData: {}
  });
  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === Const.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === 0) {
        serverData.result = resultJson.result;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `网络请求失败，请稍后重试：&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = '网络请求失败，请稍后重试!';
    return serverData;
  })
}