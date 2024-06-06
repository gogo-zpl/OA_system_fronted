//调岗申请ChangePositionAppli1
import Title from '../components/title/Title'
import http from '@ohos.net.http';
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct ChangePositionAppli1{
  @State textposition:string=''//转入职位
  @State textbranch:string=''//转入部门
  @State name:string=''//申请人


  controller2: TextAreaController = new TextAreaController()
  controller3: TextAreaController = new TextAreaController()
  controller4: TextAreaController = new TextAreaController()

  baseUrl:string = 'http://172.16.24.50:8080'

  async subhttpRequest() {
    // 构建请求体
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const requestBody = {
      employeeId: id, //
      transferToDepartment:this.textbranch,
      transferToPosition:this.textposition
      //meeting_time: this.selectedDate1.toISOString().split('T')[0], // 格式化为日期字符串


    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/applyTransfer`,//调岗
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
      Title({ pageTitle: '调岗申请' })
      Divider().color($r('app.color.line_grey'))

      Button('选择转入部门', { type: ButtonType.Capsule, stateEffect: false })
        .backgroundColor('#6CA6CD')
        .width(300)
        .height(40)
        .margin(20)
        .bindMenu([{
          value: '销售部',
          action: () => {
            this.textbranch='销售部'
            console.info(this.textbranch)
          }
        },
          {
            value: '技术部',
            action: () => {
              this.textbranch='技术部'
              console.info(this.textbranch)
            }
          },
          {
            value: '人力资源部',
            action: () => {
              this.textbranch='人力资源部'
              console.info(this.textbranch)
            }
          },
          {
            value: '财政部',
            action: () => {
              this.textbranch='财政部'
              console.info(this.textbranch)
            }
          },
          {
            value: '营销部',
            action: () => {
              this.textbranch='营销部'
              console.info(this.textbranch)
            }
          }
        ])//bindmenu()

      Row({ space: 25 }){
        Text('转入职位')
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
      .margin({top:10, bottom:30})
      .width('90%')
      //############################按钮
      Column(){
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