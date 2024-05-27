import router from '@ohos.router'
@Entry
@Component
struct SignIn {

  build() {
    Column() {
      Row() {
        Image($r('app.media.fanhui'))
          .width(30)
          .margin({ top: 10, right: 120 })
          .onClick(() => {
            //返回到首页
            router.back()
          })
        Text('签到')
          .fontSize(30)
          .margin({ top: 10, right: 100 })
      }.width('100%').backgroundColor('#fff').height(50)
      Row(){
        Button('签到')
          .type(ButtonType.Circle).width(130).margin({top:80}).fontSize(30)
          .onClick(()=>{
            //签到计数加一
          })
        Button('签退')
          .type(ButtonType.Circle).width(130).margin({top:80,left:50}).fontSize(30)
          .onClick(()=>{
            //签退计数加一
          })
      }
      Row() {
        Column() {
          Text('考勤状态表:').fontWeight(FontWeight.Bold).margin({ right: 150 ,top:10}).fontSize(20)
          Column({space:10}) {
            Text('状态: ').fontSize(18).margin({right:30})
            Text('签到时间: ').fontSize(18)
            Text('签退时间: ').fontSize(18)
            Text('操作人: ').fontSize(18).margin({right:20})
          }.margin({right:150,top:20})
        }
      }.backgroundColor('#fff').margin({top:80}).borderRadius(25).width('100%').height(200)
      .backgroundColor('#bec1d1')
    }
    .width('100%').height('100%').backgroundColor('#eee')
  }
}