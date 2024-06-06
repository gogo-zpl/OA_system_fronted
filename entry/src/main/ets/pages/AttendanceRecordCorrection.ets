import router from '@ohos.router'
import Title from '../components/title/Title'
import RepairCardInfo,{RepairCardResponse} from '../viewmodel/RepairCardInfo'
import RepairCardModel from '../model/RepairCardModel'
let employee_name = router.getParams()['employee_name']
@Entry
@Component
struct AttendanceRecordCorrection {
  private repairCardInfo:RepairCardInfo ={
    make_up_card_id:0,
    employee_id:0,
    application_date:new Date(),
    remark:'', //备注
    approver_id:0,
    is_approved:0,
    name:''
  }
  selectedDate: Date = new Date("2024-5-1")  //日期
  @State reason :string = '' //原因
  @State Applicants :string = ''  //申请人
  @State Approval : string = ''  //审批人
  build() {
    Column() {
      Title({ pageTitle: '补签申请' })
      Divider().color($r('app.color.line_grey'))


      // Row() {
      //   Text('补卡时间').width(100).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30, right: 50 })
      //   Button("选择日期").margin({ top: 30 }).width(150).backgroundColor('#bec1d1').onClick(() => {
      //     DatePickerDialog.show({
      //       start: new Date("2024-5-1"),
      //       end: new Date("2100-12-31"),
      //       selected: this.repairCardInfo.applicationDate,
      //       onAccept: (value: DatePickerResult) => {
      //         this.repairCardInfo.applicationDate.setHours(value.year, value.month)
      //         console.log('申请时间:', this.repairCardInfo.applicationDate.toString());
      //       },
      //       onCancel: () => {
      //         console.info("DatePickerDialog:onCancel()")
      //       },
      //     })
      //   })
      //   Button('选择时间').margin({top:30}).width(150).backgroundColor('#bec1d1').onClick(() => {
      //     DatePickerDialog.show({
      //       start:new Da
      //     })
      //   })
      //
      // }
      Row({space:15}) {
        Column(){
          Text('补卡时间：')
            .fontSize(20).fontWeight(FontWeight.Bold).margin({left:30})
        }
        Column(){
          Button("选择日期")
            .width(90)
            .height(35)
            .backgroundColor('#0099ff')
            .borderRadius(0)
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2024-5-1"),
                end: new Date("2100-12-31"),
                selected: this.repairCardInfo.application_date,
                onAccept: (value: DatePickerResult) => {
                  this.repairCardInfo.application_date.setFullYear(value.year, value.month, value.day)
                  console.log('截止时间:', this.repairCardInfo.application_date.toString())
                },
                onCancel: () => {
                  console.info("DatePickerDialog:onCancel()")
                }
              })
            })
        }
        Column(){
          Button('选择时间')
            .width(90)
            .height(35)
            .backgroundColor('#0099ff')
            .onClick(() => {
              TimePickerDialog.show({
                selected: this.repairCardInfo.application_date,
                useMilitaryTime: true,
                onAccept: (value: TimePickerResult) => {
                  this.repairCardInfo.application_date.setHours(value.hour, value.minute)
                  console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
                  console.log("Selected Date and Time after Time Picker:", this.repairCardInfo.application_date.toString())
                },
                onChange: (value: TimePickerResult) => {
                  console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })
        }
      }
      .margin({top:20,bottom:10})
      .height(50)
      .width('100%')

      Divider().color($r('app.color.line_grey_light'))

      Text('补卡理由').width(100).fontSize(20).fontWeight(FontWeight.Bold).margin({ top: 30, right: 200 })
      TextArea({ placeholder: '请输入补卡理由' })
        .placeholderFont({size:18,weight:'400'})
        .width(300)
        .height('40%')
        .margin({ top: 20 })
        .backgroundColor('#ffffff')
        .borderRadius(0)
        .onChange(value => {
          this.repairCardInfo.remark = value
          console.log(this.repairCardInfo.remark)
        })


      Button('提交申请').margin({top:30}).width(120).fontSize(20)
        .onClick(()=>{
          //提交申请
          RepairCardModel.RepairCardApply(this.repairCardInfo)
            .then((message:RepairCardResponse) => {
              if (message.code === 1) {
                router.back()
                console.log('Data:', message.data)
              }else{
                console.log('申请失败');
              }
            })
            .catch(error => {
              console.log(error)
            })
        })
    }
    .width('100%').height('100%').backgroundColor('#F0F8FF')
  }//build
}