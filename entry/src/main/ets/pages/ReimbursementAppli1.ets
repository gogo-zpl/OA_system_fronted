//ReimbursementAppli报销申请
import http from '@ohos.net.http';
import Title from '../components/title/Title'
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct ReimbursementAppli1{
  @State message1: string = '费用报销单'
  @State text1reson: string = ''//原因
  amount : number = 0


  //@State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  controller: TextAreaController = new TextAreaController()
  controller2: TextAreaController = new TextAreaController()
  controller3: TextAreaController = new TextAreaController()
  selectedDate1: Date = new Date("2024-5-31")
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
      amount: this.amount,
      reason:this.text1reson,
      claim_time:this.formatDate(this.selectedDate1)
      //meeting_time: this.selectedDate1.toISOString().split('T')[0], // 格式化为日期字符串

    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/reimburse`,
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
      Title({ pageTitle: '费用报销单' })
      Divider().color($r('app.color.line_grey'))
      Row(){
        Column(){
          Text('报销明细')
            .fontSize(20)
        }
        .margin({right: 200})
      }.margin({top:20, bottom:6})
      TextArea({
        text: this.text1reson,
        placeholder: '请输入报销明细',
        controller: this.controller
      }).placeholderFont({ size: 16, weight: 400 })
        .width(300)
        .height(100)
        .margin(10)
        .fontSize(16)
        .onChange((value: string) => {
          this.text1reson = value
        }).backgroundColor('#B2DFEE')



      Row({ space: 30 }){
        Text('金额')
          .fontSize(20)
        TextInput({
          text: this.amount.toString(),
          placeholder: '请输入,单位：(元)',
          controller: this.controller3
        })
          .type(InputType.Number)
          .fontColor('#182431')
          .width(200)
          .onChange((value: string) => {
            const durationValue = parseInt(value); // 将字符串转换为整数
            if (!isNaN(durationValue)) { // 检查转换后的值是否为有效的数字
              this.amount = durationValue; // 更新  状态变量
              console.info("输入金额为"+this.amount.toString())
            } else {
              // 处理无效输入，例如显示错误消息或重置输入值
              console.error("请输入有效的数字")
            }
          }).backgroundColor('#B2DFEE')
      }.justifyContent(FlexAlign.SpaceAround)
      .margin({top:10, bottom:20})
      .width('90%')

      //############################按钮
      Column(){
        Divider().color($r('app.color.line_grey'))

        Button('报销类型', { type: ButtonType.Capsule, stateEffect: false })
          .backgroundColor('#6CA6CD')
          .width(300)
          .height(40)
          .margin(20)
          .bindMenu([{
            value: '交通',
            action: () => {
              console.info('交通')
            }
          },
            {
              value: '餐饮',
              action: () => {
                console.info('餐饮')
              }
            },
            {
              value: '办公用品',
              action: () => {
                console.info('办公用品')
              }
            },
            {
              value: '培训',
              action: () => {
                console.info('培训')
              }
            },
            {
              value: '通讯',
              action: () => {
                console.info('通讯')
              }
            }
          ])//bindmenu()

        Button('报销日期')
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
          .margin({top:100, bottom:10})
          .onClick(()=>{
            this.subhttpRequest()
          })


      }//column


    }

  }//build
}//struct