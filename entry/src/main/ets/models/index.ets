export class ToolBar {
  icon: ResourceStr
  label: string
}

export class FindBar {
  id: number
  label: string
}

export class ResponseResult {
  /**
   * Code returned by the network request: success, fail.
   */
  code: number;

  /**
   * Message returned by the network request.
   */
  msg?: string | Resource;

  /**
   * Data returned by the network request.
   */
  result: string | Object | ArrayBuffer;

  constructor() {
    this.code = 0;
    this.msg = '';
    this.result = '';
  }
}