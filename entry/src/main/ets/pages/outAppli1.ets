import Title from '../components/title/Title'
import PreferencesUtil from '../util/preferencesUtil'
@Entry
@Component
struct outAppli1{

  @State text1reson: string = ''//外出原因

  time : number = 0
  selectedDate1: Date = new Date("2024-5-24")//日期和开始时间
  selectedDate2: Date = new Date("2024-5-24")//结束时间，日期都是同一天


  //@State positionInfo: CaretOffset = { index: 0, x: 0, y: 0 }
  controller: TextAreaController = new TextAreaController()

  controller3: TextAreaController = new TextAreaController()
  build(){
    Column(){
      Title({ pageTitle: '外出申请' })
      Divider().color($r('app.color.line_grey'))
      Row(){
        Column(){
          Text('外出工作内容')
            .fontSize(20)
        }
        .margin({right: 180})
      }.margin({top:20, bottom:6})
      TextArea({
        text: this.text1reson,
        placeholder: '请输入外出工作内容',
        controller: this.controller
      }).placeholderFont({ size: 16, weight: 400 })
        .width(300)
        .height(150)
        .margin(10)
        .fontSize(16)
        .onChange((value: string) => {
          this.text1reson = value
        }).backgroundColor('#B2DFEE')



      Row({ space: 30 }){
        Text('预计外出时长')
          .fontSize(20)
        TextInput({
          text: this.time.toString(),
          placeholder: '申请时长（单位：h）',
          controller: this.controller3
        })
          .type(InputType.Number)
          .fontColor('#182431')
          .width(150)
          .onChange((value: string) => {
            const durationValue = parseInt(value); // 将字符串转换为整数
            if (!isNaN(durationValue)) { // 检查转换后的值是否为有效的数字
              this.time = durationValue; // 更新 duration 状态变量
              console.info("输入加班时长为"+this.time.toString())
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

        Button('外出日期')
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
                this.selectedDate2=this.selectedDate1
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))

              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
              onChange: (value: DatePickerResult) => {
                console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })//onclick
        Row({ space: 15 }){


          Button('开始时间')
            .backgroundColor('#6CA6CD')
            .width(140)
            .height(40)
            .margin(10)
        }.justifyContent(FlexAlign.SpaceAround)//row
        .margin({top:10, bottom:6})
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


      }//column


    }

  }//build
}//struct