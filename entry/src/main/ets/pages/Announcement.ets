import router from '@ohos.router'
import Title from '../components/title/Title'
let id =router.getParams()['id']
let content = router.getParams()['content']
let title = router.getParams()['title']
let time = router.getParams()['time']
let employee_name = router.getParams()['employee_name']
@Entry
@Component
struct Announcement {
  scroller: Scroller = new Scroller()
  build() {
    Column() {
      Row() {
        Title({ pageTitle: '公告详情' })
      }.width('100%')
      Divider().color($r('app.color.line_grey'))
      //.backgroundColor('#fff').height(50)

      Row() {
        Column() {
          Row() {
            Text(title) //获取后端数据
              .fontSize(22)
              .margin({ top: 15 ,left:15})
              .fontWeight(FontWeight.Bold)
          }

          Row() {
            Text('发布人:' +employee_name)
              .fontColor('#8B8989')//获取后端数据
              .fontSize(15)
              .margin({ top: 10 ,left:15})

          }
          Row(){
            Text('发布时间:' + time)
              .fontColor('#8B8989')
              .fontSize(15)
              .margin({ top: 5 ,left:15})
          }
          .margin({bottom:10})
          Divider().color($r('app.color.line_grey'))




        }
        .alignItems(HorizontalAlign.Start)
        .backgroundColor("#FFFFFF")
        .width('100%')
        .height(105)
        //.height(120).backgroundColor('#fff').margin({ top: 20 }).borderRadius(20)
      }
      Flex(){
        Column(){
          Scroll(this.scroller) {
            Row(){
              Text(content)
                .lineHeight(27)
                .fontSize(17)
            }
            .margin({left:20,top:15,bottom:40})
          }
          .width('95%')
        }.justifyContent(FlexAlign.Center)

      }
      .backgroundColor("#FFFFFF")
      //读取后端数据


    }
    .width('100%').height('100%')//
    .backgroundColor('#F0F8FF')//#eee
  }
}