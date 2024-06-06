import router from '@ohos.router'
import Title from '../components/title/Title'
import announcementModel from '../model/AnnouncementModel'
import AnnouncementInfo,{AnnouncementResponse,UpAnnouncementResponse} from '../viewmodel/AnnouncementInfo'
@Entry
@Component
struct UpAnnouncement {
  @State headline :string = ''  //获取公告标题
  @State content :string = ''   //获取公告内容
  private announcementInfo: AnnouncementInfo = {
    initiator_id:0,
    content:'',
    title:''
  }
  build() {
    Column() {
      Title({ pageTitle: '发布公告' })
      Divider().color($r('app.color.line_grey'))

      Column(){
        TextInput({placeholder : '请输入公告标题'})
          .placeholderFont({size:'25',weight:'600'})
          .placeholderColor('#b8b8b8')
          .fontColor('black')
          .fontSize(30)
          .fontWeight('500')
          .type(InputType.Normal)
          .backgroundColor('#FFFFFF')
          .width('100%')
          .height(75)
          .onChange(value=>{
            this.announcementInfo.title = value
          })
      }
      .margin({top:10})
      Divider().color($r('app.color.line_grey'))

      Row(){
        Column(){
          Row(){
            Column(){
              Text('公告内容')
                .fontWeight('600')
                .fontColor('black')
                .fontSize(20)
                .padding({right:250,top:20})
              TextArea({placeholder:'请输入公告内容'}).width(310).height('60%')
                .placeholderFont({size:17})
                .fontSize(17)
                .margin({top:15})
                .borderRadius(0)
                .backgroundColor('#F0F8FF')
                .onChange(value=>{
                  this.announcementInfo.content = value
                  console.log(this.content)
                })
            }
          }
          Row(){
            Button('确认发布')
              .width(120).height(50).margin({top:20})
              .onClick(()=>{
                //确认数据 this.content/this.headline
                announcementModel.UpAddAnnouncement(this.announcementInfo)
                  .then((message:UpAnnouncementResponse) => {
                    if (message.code === 1) {
                      router.back()
                      console.log('Data:', message.data)
                    }else{
                      console.log('发布失败');
                    }
                  })
                  .catch(error => {
                    console.log(error)
                  })
              })
          }
        }
      }
    }.width('100%').height('100%').backgroundColor('#ffffff')
  }
}