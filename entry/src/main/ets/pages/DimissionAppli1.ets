//离职申请
import http from '@ohos.net.http';
import Title from '../components/title/Title'
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct DimissionAppli1{
  @State text1: string = ''//原因
  @State text2: string = ''//名字


  //@State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  controller: TextAreaController = new TextAreaController()
  controller2: TextAreaController = new TextAreaController()

  baseUrl:string = 'http://172.16.24.50:8080'

  async subhttpRequest() {
    // 构建请求体
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const requestBody = {
      employee_id: id, //
      reason:this.text1,
      //meeting_time: this.selectedDate1.toISOString().split('T')[0], // 格式化为日期字符串

    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/applyResignation`,//离职
        {
          method:http.RequestMethod.POST,
          extraData: JSON.stringify(requestBody),
          header:{
            'Content-Type': 'application/json'
          },
          connectTimeout:10000,
          readTimeout:10000
        }
      ).then(resp=>{
        if(resp.responseCode === 200){
          //查询成功
          console.log('http--成功',resp.result)
          resolve(JSON.parse(resp.result.toString()))
          console.info(JSON.stringify(requestBody).toString())
        }else{
          console.log('http--失败1',resp.result)
          console.info('http--失败2',JSON.stringify(requestBody).toString())
          reject('申请失败')
        }//else
      }).catch(
        error => {
          console.info('申请失败error(catch):'+JSON.stringify(error))
          reject('申请失败')
        }
      ) //request
    })
  }//sub

  build(){
    Column(){
      Title({ pageTitle: '离职申请' })
      Divider().color($r('app.color.line_grey'))
      //#####################


      Row(){
        Column(){
          Text('申请原因')
            .fontSize(20)
        }
        .margin({right: 200})
      }.margin({top:30, bottom:6})
      TextArea({
        text: this.text1,
        placeholder: '请输入申请原因',
        controller: this.controller
      }).placeholderFont({ size: 16, weight: 400 })
        .width(300)
        .height(200)
        .margin({top:10, bottom:35})
        .fontSize(16)
        .onChange((value: string) => {
          this.text1 = value
        }).backgroundColor('#B2DFEE')


      //############################按钮
      Button('提交申请')
        .fontSize(24)
        .backgroundColor('#3399FF')
        .width(150)
        .height(40)
        .margin({top:100, bottom:10})
        .onClick(()=>{
          this.subhttpRequest()
        })


    }

  }//build
}//struct