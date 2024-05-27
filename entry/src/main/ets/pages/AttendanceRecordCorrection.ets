import router from '@ohos.router'
@Entry
@Component
struct AttendanceRecordCorrection {

  selectedDate: Date = new Date("2024-5-1")  //日期
  @State reason :string = '' //原因
  @State Applicants :string = ''  //申请人
  @State Approval : string = ''  //审批人
  build() {
      Column() {
        Row() {
          Image($r('app.media.fanhui'))
            .width(30)
            .margin({ top: 10, right: 100 })
            .onClick(() => {
              //返回到首页
              router.back()
            })
          Text('补签申请')
            .fontSize(30)
            .margin({ top: 10, right: 100 })
        }.width('100%').backgroundColor('#fff').height(50)

        Row() {
          Text('补卡时间').width(100).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30, right: 50 })
          Button("选择日期").margin({ top: 30 }).width(150).backgroundColor('#bec1d1').onClick(() => {
            DatePickerDialog.show({
              start: new Date("2024-5-1"),
              end: new Date("2100-12-31"),
              selected: this.selectedDate,
              onAccept: (value: DatePickerResult) => {
                this.selectedDate.setHours(value.year, value.month)
                console.log('申请时间:', this.selectedDate.toString());
              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
            })
          })
        }

        Text('补卡理由').width(100).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30, right: 200 })
        TextArea({ placeholder: '请输入补卡理由' })
          .width(300)
          .height('40%')
          .margin({ top: 30 })
          .backgroundColor('#bec1d1')
          .onChange(value => {
            this.reason = value
            console.log(this.reason)
          })
        Row() {
          Text('申请人').width(80).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30})
          TextInput({ placeholder: '请输入姓名' }).backgroundColor('#bec1d1').margin({top:30}).width(200)
            .onChange(value=>{
              this.Applicants=value
              console.info('申请人'+this.Applicants)
            })
        }
        Row() {
          Text('审批人').width(80).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30})
          TextInput({ placeholder: '请输入姓名' }).backgroundColor('#bec1d1').margin({top:30}).width(200)
            .onChange(value=>{
            this.Approval=value
            console.info('审批人'+this.Approval)
          })
        }
        Button('提交申请').margin({top:30}).width(120).fontSize(20)
          .onClick(()=>{
            //提交申请
          })
      }
      .width('100%').height('100%').backgroundColor('#eee')
  }
}