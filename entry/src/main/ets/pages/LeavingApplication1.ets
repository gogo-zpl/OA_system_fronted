import Title from '../components/title/Title'
import http from '@ohos.net.http';
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct LeavingApplication1{
  @State message1: string = '请假申请单'
  @State text1: string = ''//原因
  @State text2: string = ''//名字
  @State type: string = ''//类型

  selectedDate1: Date = new Date("2024-5-24")//开始
  selectedDate2: Date = new Date("2024-5-24")//结束


  //@State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  controller: TextAreaController = new TextAreaController()
  controller2: TextAreaController = new TextAreaController()
  baseUrl:string = 'http://172.16.24.50:8080'
  formatDate(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = date.getDate().toString().padStart(2, '0');
    const hours = date.getHours().toString().padStart(2, '0');
    const minutes = date.getMinutes().toString().padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:00`;
  }


  async subhttpRequest() {
    // 构建请求体
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const requestBody = {
      employee_id:id,
      start_time:this.formatDate(this.selectedDate1),
      end_time:this.formatDate(this.selectedDate2),
      reason:this.text1,
      leave_type:this.type,
    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/applyTake_off`,
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
  }//submitMeetingRequest()

  build(){
    Column(){
      Title({ pageTitle: '请假申请单' })
      Divider().color($r('app.color.line_grey'))
      Row(){
        Column(){
          Text('请假说明')
            .fontSize(20)
        }
        .margin({right: 200})
      }.margin({top:10, bottom:6})
      TextArea({
        text: this.text1,
        placeholder: '请输入请假原因',
        controller: this.controller
      }).placeholderFont({ size: 16, weight: 400 })
        .width(300)
        .height(100)
        .margin(10)
        .fontSize(16)
        .onChange((value: string) => {
          this.text1 = value
        }).backgroundColor('#B2DFEE')


//############################按钮
      Column(){
        Divider().color($r('app.color.line_grey'))
        Button('请假类型', { type: ButtonType.Capsule, stateEffect: false })
          .backgroundColor('#6CA6CD')
          .width(300)
          .height(40)
          .margin(20)
          .bindMenu([{
                value: '病假',
                action: () => {
                  this.type='病假'
                  console.info(this.type)
                }
              },
              {
                value: '因公外出',
                action: () => {
                  this.type='因公外出'
                  console.info(this.type)
                }
              },
              {
                value: '产假',
                action: () => {
                  this.type='产假'
                  console.info(this.type)
                }
              },
            {
              value: '婚假',
              action: () => {
                this.type='婚假'
                console.info(this.type)
              }
            },
              {
                value: '事假',
                action: () => {
                  this.type='事假'
                  console.info(this.type)
                }
              }]
            )//bindmenu()
        Row({ space: 15 }){
          Button('开始日期')
            .backgroundColor('#6CA6CD')
            .width(140)
            .height(40)
            .margin(10)
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
        })

          Button('开始时间')
            .backgroundColor('#6CA6CD')
            .width(140)
            .height(40)
            .margin(10)
        }.justifyContent(FlexAlign.SpaceAround)//row
        .margin({top:0, bottom:6})
        .width('90%')
        .onClick(() => {
          TimePickerDialog.show({
            selected: this.selectedDate1,
            useMilitaryTime: true,
            onAccept: (value: TimePickerResult) => {
              this.selectedDate1.setHours(value.hour, value.minute)
              console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
              console.log("Selected Date1 and Time after Time Picker:", this.selectedDate1.toString());
            },
            onCancel: () => {
              console.info("TimePickerDialog:onCancel()")
            },
            onChange: (value: TimePickerResult) => {
              console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
            }
          })
        })//onclick

        //#####################
        Row({ space: 15 }){
          Button('结束日期')
            .backgroundColor('#6CA6CD')
            .width(140)
            .height(40)
            .margin(10)
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2024-5-1"),
                end: new Date("2100-12-31"),
                selected: this.selectedDate2,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedDate2.setFullYear(value.year, value.month, value.day)
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))

                },
                onCancel: () => {
                  console.info("DatePickerDialog:onCancel()")
                },
                onChange: (value: DatePickerResult) => {
                  console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })

          Button('结束时间')
            .backgroundColor('#6CA6CD')
            .width(140)
            .height(40)
            .margin(10)
        }.justifyContent(FlexAlign.SpaceAround)//row
        .margin({top:0, bottom:6})
        .width('90%')
        .onClick(() => {
          TimePickerDialog.show({
            selected: this.selectedDate2,
            useMilitaryTime: true,
            onAccept: (value: TimePickerResult) => {
              this.selectedDate2.setHours(value.hour, value.minute)
              console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
              console.log("Selected Date2 and Time after Time Picker:", this.selectedDate2.toString());
            },
            onCancel: () => {
              console.info("TimePickerDialog:onCancel()")
            },
            onChange: (value: TimePickerResult) => {
              console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
            }
          })
        })//onclick
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