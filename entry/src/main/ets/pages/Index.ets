import router from '@ohos.router'
import LoginResponse, {EmployeeData} from '../viewmodel/LoginInfo'
import ChangePasswordInfo,{ChangePasswordResponse} from '../viewmodel/ChangePasswordInfo'
import Register from '../model/RegisterModel'
import registerModel from '../model/RegisterModel'
import announcementModel from '../model/AnnouncementModel'
import {AnnouncementResponse,AnnouncementData} from '../viewmodel/AnnouncementInfo'
import PreferencesUtil from '../util/preferencesUtil'
class Announce {
  // name: string
  time: Date
  id:number
  title:string
  content:string

  constructor(title: string, time: Date,id:number,content:string) {
    this.title = title
    this.time = time
    this.id = id
    this.content = content
  }
}
//获取页面路由传输的数据
let employee_name = router.getParams()['name']
let birthdate = router.getParams()['birthdate']
let  department_name = router.getParams()['department_name']
let phone_number = router.getParams()['phone_number']
let position = router.getParams()['position']
let permission = router.getParams()['permission']

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State employee_id:number = 0
  @State announces: Array<Announce> = [];
  @State announcementData: AnnouncementData | null = null
  dialogController: CustomDialogController = new CustomDialogController({
    builder: PasswordDialog({}),
  })   //修改密码弹窗

  //权限弹窗
  dialogControllerPermission:CustomDialogController = new CustomDialogController({
    builder :PermissionDialog({})
  })
  aboutToAppear() {
    this.AnnouncementsList()
  }
  private controller: TabsController = new TabsController()

  AnnouncementsList() {
    //const announcementService = new AnnouncementService('http://your-api-url.com');
    announcementModel.GetAnnouncements()
      .then((response:AnnouncementData[]) => {
        this.announces = response.map((item: AnnouncementData) => new Announce(item.title, new Date(item.publish_time),item.announcement_id,item.content));
        console.log(this.announces.toString())
        // this.updateUI();
      })
      .catch(error => {
        console.error('公告获取失败', error);
      });
  }

  @Builder //修饰导航栏
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource,
             normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? normalImg : selectedImg)
        .size({ width: 30, height: 30 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.controller.changeIndex(this.currentIndex);
    })
  }

  build() {
    Tabs({barPosition:BarPosition.End,controller:this.controller}){

      //page1-首页
      TabContent() {//TabContent
        Column() {
          Row() {
            //Image('https://mfile.rrxiu.net/g1/poster/2196277/p_72485904.png?v=1630889856@!user_image_800x1')
            Image('/pages/img/tongzhipage2.jpg')
              .width('96%')
              .borderRadius(10)
              .height(200)
              .margin({top:8})
          }
          .margin({bottom:5})

          //.height(300)
          //.backgroundColor('#B4D2E4')
          Row() {

            Button(){
              Row(){
                Image('/pages/img/daibanpage2.png')
                  .width(50)
                Text('待办事项')
                  .fontSize(22)
                  .fontColor('#1E90FF')
                  .margin({left:10})
                  .fontWeight(FontWeight.Bold)
              }
            }
            .fontSize(20)
            .fontWeight('600')
            .backgroundColor('#ffffff')
            .type(ButtonType.Normal)
            .borderRadius(10)
            .width('100%')
            .height('100%')
            .onClick(()=>{
              //跳转到待办事项页面
              router.pushUrl({
                url:'pages/Todo',
                params:{id:1}
              },
                router.RouterMode.Single,
                err=>{
                  if(err){
                    console.log('路由失败')
                  }
                }
              )
            })//onclick
          }
          .margin({top:10})
          .borderRadius(10)
          .width('95%')
          .height(80)

          List({space:10}){
            ForEach(this.announces,
              (announce:Announce)=>{
                ListItem(){
                  Row(){
                    Image('/pages/img/gonggaopage.png')
                      .height(60)
                      .width(60)
                      .margin({left:20})
                    Column(){
                       Text(announce.title)
                         .fontSize(22)
                         .margin({ top: 10 })
                         .fontWeight('600')
                        Text(`${announce.time.getFullYear()}-${(announce.time.getMonth() + 1).toString()
                          .padStart(2, '0')}-${announce.time.getDate().toString().padStart(2, '0')}`)
                          .fontSize(16)
                          .margin({ top: 7 })
                          .fontColor(Color.Gray)
                          .fontWeight(FontWeight.Bold)
                    }.margin({left:15})
                    .alignItems(HorizontalAlign.Start)
                  }
                  .justifyContent(FlexAlign.Start)
                  .width('100%')
                  .height(120)
                  //.padding({left:14, right:14})
                  .backgroundColor('#fff')
                  .borderRadius(10)
                  .onClick(()=>{
                    //跳转公告详情页
                    const year = announce.time.getFullYear();
                    const month = (announce.time.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
                    const day = announce.time.getDate().toString().padStart(2, '0');
                    const hours = announce.time.getHours().toString().padStart(2, '0');
                    const minutes = announce.time.getMinutes().toString().padStart(2, '0');
                    router.pushUrl({
                      url:'pages/Announcement',
                      params:{
                        id: announce.id,
                        content: announce.content,
                        title: announce.title,
                        time:`${year}-${month}-${day} ${hours}:${minutes}`,
                        employee_name:employee_name
                      }
                    },
                      router.RouterMode.Single,
                      err=>{
                        if(err){
                          console.log('路由失败')
                        }
                      }
                    )
                  })//click
                }//list
              })
          }
          .padding({left:10,right:10,top:10})
          .layoutWeight(1)
        }//大colun
        .width('100%').height('100%')
        .backgroundImage('/pages/img/back6.jpg')
        .backgroundImageSize(ImageSize.Cover)
        //.backgroundColor('#eee')

      }//tabc
      .tabBar(this.TabBuilder('首页',0,$r('app.media.shouye'),$r('app.media.shouyeselect')))

      //page2-工作台界面
      TabContent() {
        //page2-column#########################################################
        Column(){
          //headline
          Row(){
            Text('OA 办公系统')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1E90FF')
              .margin({left:100,top:10,bottom:10})
          }
          .backgroundColor(Color.White)
          .width('100%')

          //签到，考勤
          Row({space:15}){
            Button('考勤打卡')
              .onClick(()=>{
                //跳转到考勤打卡页面
                router.pushUrl({
                  url:'pages/Attendance',
                  params:{id:1}
                },
                  router.RouterMode.Single,
                  err=>{
                    if(err){
                      console.log('路由失败')
                    }
                  }
                )
              })
              .fontSize(20)
              .borderRadius(7)
              .width('45%')
              .height(90)
              .type(ButtonType.Normal)
              .backgroundColor('#1E90FF')
            Button('签到')
              .onClick(()=>{
                //跳转到签到界面
                router.pushUrl({
                  url:'pages/SignIn',
                  params:{employee_name:employee_name}
                },
                  router.RouterMode.Single,
                  err=>{
                    if(err){
                      console.log('路由失败')
                    }
                  }
                )
              })
              .fontSize(20)
              .width('45%')
              .height(90)
              .borderRadius(7)
              .type(ButtonType.Normal)
              .backgroundColor('#FFb90f')
          }
          .height(110)
          //事务管理
          Row() {
            Column() {
              Text('事务管理')
                .fontSize(20)
                .fontWeight('600')
                .margin({ left: 30,bottom:8})
                .width('100%')
              Divider().color($r('app.color.line_grey'))

              Row({space:30}){
                Column() {
                  Image('/pages//img/qingjia.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到请假界面
                      router.pushUrl({
                        url: 'pages/LeavingApplication1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('请假')
                    .width(40)
                    .margin({left:8,bottom:10})
                }//column qingjia
                Column() {
                  Image('/pages//img/chuchai.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到出差界面
                      router.pushUrl({
                        url: 'pages/TravelApplication1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('出差')
                    .width(40)
                    .margin({left:8,bottom:10})
                  // .margin({left:30})
                }

                Column() {
                  Image('/pages/img/buka.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到补卡界面
                      router.pushUrl({
                        url:'pages/AttendanceRecordCorrection',
                        params:{id:1}
                      },
                        router.RouterMode.Single,
                        err=>{
                          if(err){
                            console.log('路由失败')
                          }
                        }
                      )
                    })
                  Text('补卡')
                    .margin({left:8,bottom:10})
                    .width(40)
                  // .margin({left:30})
                }
                Column() {
                  Image('/pages//img/baoxiao.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到报销界面
                      router.pushUrl({
                        url: 'pages/ReimbursementAppli1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('报销')
                    .width(40)
                    .margin({left:8,bottom:10})
                }//colubaoxiao
              }.width('100%')
              .height(50)
              .margin({left:50,bottom:30})
              //row1

              Row({space:20}){
                Column() {
                  Image('/pages/img/huiyishenqing.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:25})
                    .onClick(()=>{
                      //跳转到会议申请界面
                      router.pushUrl({
                        url: 'pages/MeetingAppli1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('会议申请')
                    .width(70)
                    .margin({left:10,top:5})
                }
                Column() {
                  Image('/pages/img/jiaban.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:25})
                    .onClick(()=>{
                      //跳转到加班界面
                      router.pushUrl({
                        url: 'pages/OvertimeApplication1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('加班')
                    .width(40)
                    .margin({left:10,top:5})
                }
                Column() {//查看
                  Image('/pages//img/chakanyitonguo.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:25})
                    .onClick(()=>{
                      //查看已通过
                      router.pushUrl({
                        url: 'pages/ApplicationShow',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('查看')
                    .width(40)
                    .margin({left:10,top:5})
                }//colubaoxiao
                .margin({left:10})
              }//row
              .margin({left:16})
              .width('100%')
            }
          }//rowshiwu
          .backgroundColor('#ffffff')
          .height(240)
          .width('95%')
          .borderRadius(15)

          //人事管理
          Row(){
            Column(){
              Text('人事管理')
                .fontSize(20)
                .fontWeight('600')
                .margin({ left: 30,bottom:8,top:10})
                .width('100%')
              Divider().color($r('app.color.line_grey'))

              Row({space:30}){
                Column() {
                  Image('/pages/img/zhuanzheng.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到转正界面
                      router.pushUrl({
                        url: 'pages/RegularAppli1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('转正')
                    .width(40)
                    .margin({left:10,top:3,bottom:10})
                }
                Column() {
                  Image('/pages/img/tiaogang.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到调岗界面
                      router.pushUrl({
                        url: 'pages/ChangePositionAppli1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('调岗')
                    .width(40)
                    .margin({left:10,top:3,bottom:10})
                }
                Column() {
                  Image('/pages/img/lizhi.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到离职界面
                      router.pushUrl({
                        url: 'pages/DimissionAppli1',
                        params: {id:1}
                      }, router.RouterMode.Single, err => {
                        if (err) {
                          console.log('路由失败');
                        }
                      })
                    })
                  Text('离职')
                    .width(40)
                    .margin({left:10,top:3,bottom:10})
                }
              }.width('100%')
              .margin({left:50})
            }
          }//renshirow
          .backgroundColor('#ffffff')
          .margin({top:10,bottom:10})
          .width('95%')
          .borderRadius(10)
          //其他
          Row(){
            Column(){
              Text('其他')
                .fontSize(20)
                .fontWeight('600')
                .margin({ left: 30,bottom:8,top:10})
                .width('100%')
              Divider().color($r('app.color.line_grey'))

              Row(){
                Column() {
                  Image('/pages/img/daiban.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到待办事项界面
                      router.pushUrl({
                        url:'pages/Todo',
                        params:{id:1}
                      },
                        router.RouterMode.Single,
                        err=>{
                          if(err){
                            console.log('路由失败')
                          }
                        }
                      )
                    })
                  Text('待办事项')
                    .width(80)
                    .margin({left:10,top:3,bottom:10})
                }
                .margin({left:5})
                Column() {
                  Image('/pages/img/shenpi.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到审批中心界面
                      if(permission==1) {
                        router.pushUrl({
                          url: 'pages/ApprovalCenter1',
                          params: { id: 1 }
                        }, router.RouterMode.Single, err => {
                          if (err) {
                            console.log('路由失败');
                          }
                        })
                      }
                      else{
                        console.log('您没有这个权限')
                        this.dialogControllerPermission.open()
                      }
                    })
                  Text('审批中心')
                    .width(80)
                    .margin({left:10,top:3,bottom:10})
                }

                Column() {
                  Image('/pages/img/gonggao.png')
                    .borderRadius(10)
                    .width(50)
                    .height(50)
                    .margin({top:15,bottom:3})
                    .onClick(()=>{
                      //跳转到公告发布界面
                      router.pushUrl({
                        url:'pages/UpAnnouncement',
                        params:{id:1}
                      },
                        router.RouterMode.Single,
                        err=>{
                          if(err){
                            console.log('路由失败')
                          }
                        }
                      )
                    })
                  Text('公告发布')
                    .width(80)
                    .margin({left:10,top:3,bottom:10})
                }
              }.width('100%')
            }
          }//rowqita
          .backgroundColor('#ffffff')
          .margin({bottom:10})
          .width('95%')
          .borderRadius(10)
        }
        .width('100%').height('100%')
        .backgroundImage('/pages/img/back3.jpg')
        .backgroundImageSize(ImageSize.Cover)
        //.backgroundColor('#eee')
        // colunm
      }//tab2colum
      .tabBar(this.TabBuilder('工作台',1,$r('app.media.Workbench'),$r('app.media.Workbenchselect')))

      //page2#############################################################

      //page3-我的界面######################################################
      TabContent() {//TabContent
        Column(){
          Row(){
            Image('/pages/img/geren.png')
              .width(30)
              .margin({left:100})
            Text('个人信息')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({left:10})
          }
          .height(60)
          .backgroundColor(Color.White)
          .width('100%')
          Row(){
            Image('/pages/img/touxiang.jpg')
              .height(150)
              .width(150)
              .borderRadius(15)

          }.margin({bottom:15,top:20})

          //读取后端数据 this.name？？
          Column({space:10}){
            Row(){
              Text('姓名')
                .fontSize(20)
                .margin({top:15})
                .fontColor(Color.Gray)
                .fontWeight('600')
              Text(employee_name)
                .fontSize(20)
                .fontWeight('600')
                .margin({left:20,top:15})
            }.width('100%')
            .margin({left:30})

            Row(){
              Text('性别')
                .fontSize(20)
                .fontColor(Color.Gray)
                .fontWeight('600')
              Text('男')
                .fontSize(20)
                .fontWeight('600')
                .margin({left:20})
            }.width('100%')
            .margin({left:30})

            Row(){
              Text('生日')
                .fontSize(20)
                .fontColor(Color.Gray)
                .fontWeight('600')

              Text(birthdate)
                .fontSize(20)
                .margin({left:20})
                .fontWeight('600')
            }
            .margin({left:30})
            .width('100%')


          }//colun
          .height(120)
          .opacity(0.9)
          .width('90%')
          .borderRadius(10)
          .backgroundColor('#ffffff')

          Column({space:10}){
            Row(){
              Text('职位')
                .fontSize(20)
                .margin({top:15})
                .fontColor(Color.Gray)
                .fontWeight('600')
              Text(position)
                .fontSize(20)
                .fontWeight('600')
                .margin({left:20,top:15})
            }.width('100%')
            .margin({left:30})

            Row(){
              Text('电话')
                .fontSize(20)
                .fontColor(Color.Gray)
                .fontWeight('600')
              Text(phone_number)
                .fontSize(20)
                .fontWeight('600')
                .margin({left:20})
            }.width('100%')
            .margin({left:30})

            Row(){
              Text('部门')
                .fontSize(20)
                .fontColor(Color.Gray)
                .fontWeight('600')

              Text(department_name)
                .fontSize(20)
                .margin({left:20})
                .fontWeight('600')
            }
            .margin({left:30})
            .width('100%')


          }//colun
          .height(120)
          .opacity(0.9)
          .width('90%')
          .margin({top:20})
          .borderRadius(10)
          .backgroundColor('#ffffff')

          Row(){
            Image('/pages/img/xiugai.png')
              .width(25)
            Text('修改密码')
              .fontColor('#0099ff')
          }.width('100%')
          .margin({top:20,right:40})
          .justifyContent(FlexAlign.End)
          .borderColor(Color.Blue)
          .onClick(()=>{
            this.dialogController.open()
          })

          Button() {
            Row() {
              Image('/pages/img/tuichu.png')
                .width(20)
              Text('  退出登录')
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .onClick(()=>{
                  //退出到登陆界面
                  router.back()
                })
            }
          }.height(50)
          .width(150)
          .margin({top:70})
          .backgroundColor('#ea6363')
          //.backgroundColor('#0099ff')
        }
        .backgroundImage('/pages/img/back4.png')
        .backgroundImageSize(ImageSize.Cover)
        .width('100%')
        .height('100%')
      }//tabc
      .tabBar(this.TabBuilder('我的',2,$r('app.media.wode'),$r('app.media.wodeselect')))

    }//tabs
    .barWidth('100%') // 设置TabBar宽度
    .barHeight(60) // 设置TabBar高度
    .width('100%') // 设置Tabs组件宽度
    .height('100%') // 设置Tabs组件高度
    .backgroundColor('#ffffff')
    //.backgroundColor(0xF5F5F5)
  }//build
}
@CustomDialog     //修改密码弹窗
struct PasswordDialog {
  controller: CustomDialogController
  @State changePasswordInfo:ChangePasswordInfo = {id:0,oldPassword:'',newPassword:''}
  @State newPassword: string = ''  // 获取新密码
  build() {
    Column() {
      Row() {
        Text('输入新密码: ').margin({top:20})
          .fontSize(20)
        TextInput()
          .width('60%')
          .margin({top:20})
          .onChange(value=>{
            this.changePasswordInfo.newPassword=value
            console.log(this.changePasswordInfo.newPassword)
          })
      }
      Button('确认').margin({top:30})
        .fontSize(20)
        .onClick((value)=>{
          registerModel.ChangePasswordRequest(this.changePasswordInfo)
            .then((message:ChangePasswordResponse) => {
              if (message.code === 1) {
                console.log('修改成功')
                router.back()
              }else {
                console.log('修改失败');
              }
            })
            .catch(error => {
              console.log(error)
            })
          this.controller.close()
        })
    }.height(150).width('90%')
  }
}


@CustomDialog     //权限提醒弹窗
struct PermissionDialog {
  controller: CustomDialogController
  build() {
    Column() {
      Row() {
        Text('你没有权限进入').margin({top:20})
          .fontSize(24)
      }
    }.height(70).width('90%')
  }
}