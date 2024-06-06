//转正申请RegularAppli1
//申请人/转正日期/职位
import Title from '../components/title/Title'
import http from '@ohos.net.http';
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct RegularAppli1{
  @State textposition:string=''//当前职位
  @State name:string=''//申请人
  selectedDate1: Date = new Date("2024-5-24")//转正日期

  controller2: TextAreaController = new TextAreaController()
  controller3: TextAreaController = new TextAreaController()
  controller4: TextAreaController = new TextAreaController()
  baseUrl:string = 'http://172.16.24.50:8080'
  formatDate(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');

    return `${year}-${month}-${day} 00:00:00`;
  }
  async subhttpRequest() {
    // 构建请求体
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const requestBody = {
      employee_id: id, //
      approver_id:2,
      position:this.textposition,
      effective_date:this.formatDate(this.selectedDate1)
      //meeting_time: this.selectedDate1.toISOString().split('T')[0], // 格式化为日期字符串

    };
    console.log('发送的请求体：');
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/fullMemberApply`,//离职
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
          console.info('http--失败2',JSON.stringify(requestBody).toString())//
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
      Title({ pageTitle: '转正申请' })
      Divider().color($r('app.color.line_grey'))

      Row({ space: 25 }){
        Text('当前职位')
          .fontSize(20)
        TextInput({
          text: this.textposition,
          placeholder: '请输入',
          controller: this.controller4
        }).fontColor('#182431')
          .width(200)
          .onChange((value: string) => {
            this.textposition = value
          }).backgroundColor('#B2DFEE')
      }.justifyContent(FlexAlign.SpaceAround)
      .margin({top:10, bottom:10})
      .width('90%')
      //########################时间


      //############################按钮
      Column(){

        Button('转正日期')
          .backgroundColor('#6CA6CD')
          .width(300)
          .height(40)
          .margin({top:20, bottom:30})
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2024-5-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDate1,
              onAccept: (value: DatePickerResult) => {
                // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                this.selectedDate1.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))

              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
              onChange: (value: DatePickerResult) => {
                console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })//onclic
        Divider().color($r('app.color.line_grey'))
        Button('提交申请')
          .fontSize(24)
          .backgroundColor('#3399FF')
          .width(150)
          .height(40)
          .margin({top:200, bottom:10})
          .onClick(()=>{
            this.subhttpRequest()
          })
      }//column70


    }//17column

  }//build
}//struct