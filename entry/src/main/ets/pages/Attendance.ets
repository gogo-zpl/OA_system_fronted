import router from '@ohos.router'
@Entry
@Component
struct Attendance {
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
          Text('考勤打卡')
            .fontSize(30)
            .margin({ top: 10, right: 100 })
        }.width('100%').backgroundColor('#fff').height(50)
        Row() {
          Column() {
            Text('考勤统计表:').fontWeight(FontWeight.Bold).margin({ right: 150 ,top:10}).fontSize(20)
            Column({space:10}) { //调取后端数据
              Text('出勤统计: ').fontSize(18).margin({right:30})
              Text('正常签到次数: ').fontSize(18)
              Text('迟到次数: ').fontSize(18).margin({right:30})
              Text('早退次数: ').fontSize(18).margin({right:30})
            }.margin({right:150,top:0})
          }
        }.backgroundColor('#fff').margin({top:50}).borderRadius(25).width('100%').height(200)
        .backgroundColor('#bec1d1')
      }
      .width('100%').height('100%').backgroundColor('#eee')
  }
}