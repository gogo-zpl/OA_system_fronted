import router from '@ohos.router'
@Entry
@Component
struct UpAnnouncement {
  @State headline :string = ''  //获取公告标题
  @State content :string = ''   //获取公告内容
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
          Text('发布公告')
            .fontSize(30)
            .margin({ top: 10, right: 100 })
        }.width('100%').backgroundColor('#fff').height(50)
       Row(){
        Column(){
          Row(){
            Text('标题').fontSize(20)
            TextInput({placeholder : '请输入公告标题'})
              .type(InputType.Normal).backgroundColor('#bec1d1').width('60%').margin({left:30})
              .onChange(value=>{
                this.headline = value
              })
          }.width('100%').height(50).margin({top:20,left:30})
          Row(){
            Column(){
              Text('发布公告')
                .fontSize(20)
                .padding({right:250,top:20})
              TextArea({placeholder:'请输入公告内容'}).width(300).height('60%').margin({top:30})
                .backgroundColor('#bec1d1')
                .onChange(value=>{
                  this.content = value
                  console.log(this.content)
                })
            }
          }
          Row(){
            Button('确认发布')
              .width(120).height(50).margin({top:20})
              .onClick(()=>{
                //确认数据 this.content/this.headline
              })
          }
        }
       }
      }.width('100%').height('100%').backgroundColor('#eee')
  }
}