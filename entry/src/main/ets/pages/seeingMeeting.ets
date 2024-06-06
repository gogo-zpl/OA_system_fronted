import { Meeting } from '../viewmodel/meeting'
import PreferencesUtil from '../util/preferencesUtil'
@Component
export struct MeetingItem {
   meeting: Meeting; // 会议申请的数据

  build() {
    Column({ space: 16 }) {
      // 模块的顶部，显示会议时间
      Text(this.meeting.meeting_time)
        .fontSize(16)
        .margin({ bottom: 5 })

      // 模块的中部，显示会议主题
      Text(this.meeting.topic)
        .fontSize(20)
        .margin({ bottom: 5 })

      // 模块的底部，显示审批状态
      Text(this.formatApproverStatus(this.meeting.is_approved)){
      }
        .fontSize(16)
    }
    .alignItems(HorizontalAlign.Center)
    .width(300) // 设置模块的宽度
    .height(120) // 设置模块的高度
    .backgroundColor('#D1EEEE') // 设置模块的背景颜色
    .borderRadius(10) // 设置模块的圆角
    .padding(10) // 设置模块内边距
    .margin({left:30,top:10})
  }

  formatApproverStatus(status: number): string {
    switch (status) {
      case 0:
        return '未审批';
      case 1:
        return '审批通过';
      case 2:
        return '审批不通过';
      default:
        return '未知状态';
    }
  }
}