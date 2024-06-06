import router from '@ohos.router'
import AttendanceInfo from '../viewmodel/AttendanceInfo'
import AttendanceModel from '../model/AttendanceModel'
import Title from '../components/title/Title'


@Entry
@Component


struct Attendance {
  private attendanceInfo:AttendanceInfo ={
    attendance_id:0,            //签到id
    employee_id:0,               //员工id
    sign_in_status:0,           //签到状态为0，表示未签到，为1表示正常签到
    sign_in_time:new Date,                 //签到时间 yyyy-MM-dd HH:mm:ss
    sign_out_time:new Date,                //签退时间 yyyy-MM-dd HH:mm:ss
    sign_out_status:0,           // 签退状态：0表示未签退，1表示正常签退
    sign_day:new Date
  }
  @State normalCount: number = 0;
  @State lateCount: number = 0;
  @State earlyLeaveCount: number = 0;

  async onShow() {
    try {
      const data = await AttendanceModel.GetAttendanceStats(this.attendanceInfo);
      this.normalCount = data.normal;
      this.lateCount = data.late;
      this.earlyLeaveCount = data.earlyLeave;
      console.log(this.lateCount.toString())
    } catch (error) {
      console.error('获取考勤统计失败', error);
    }
  }
  aboutToAppear() {
    this.onShow()
  }

  build() {
    Column() {
      Title({ pageTitle: '考勤打卡' })
      Divider().color($r('app.color.line_grey'))
      Row() {
        Column() {
          Text('考勤统计表').fontWeight(FontWeight.Bold).margin({left:110,bottom:10 }).fontSize(20)
          Divider().color($r('app.color.line_grey'))
          Text('出勤统计: ').fontSize(18).margin({left:15,bottom:10 ,top:10}).fontWeight('600')
          Text(`正常签到次数:`+this.normalCount).fontSize(18).margin({left:15,bottom:10 })
          Text(`迟到次数: `+this.lateCount).fontSize(18).margin({left:15,bottom:10 })
          Text(`早退次数: `+this.earlyLeaveCount).fontSize(18).margin({left:15,bottom:10 })

        }.alignItems(HorizontalAlign.Start)
      }.margin({top:50}).borderRadius(0).width('90%').height(200)
      .backgroundColor('#ffffff')
    }
    .width('100%').height('100%').backgroundColor('#F0F8FF')
  }

}