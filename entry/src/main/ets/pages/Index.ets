import router from '@ohos.router'
class Announce {
  name: string
  time: string

  constructor(name: string, time: string) {
    this.name = name
    this.time = time
  }
}


@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: PasswordDialog({}),
  })

  private announces: Array<Announce> =[
    //接受数据
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23'),
    new Announce('公司今天加班','2024/5/23')
  ]
  private controller: TabsController = new TabsController()
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
        TabContent() {
          Column(){
            Column() {
              Row() {
                Image('https://mfile.rrxiu.net/g1/poster/2196277/p_72485904.png?v=1630889856@!user_image_800x1')
                  .width('100%')
                  .height(200)
                  .padding({ top: 20 })

              }
              .width('100%')
              //.height(300)
              //.backgroundColor('#B4D2E4')
              Row() {
                Button('待办事项')
                  .type(ButtonType.Normal)
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
                  })
              }
              .padding({top:20})
              .height(80)
              List({space:10}){
                ForEach(this.announces,
                  (announce:Announce)=>{
                    ListItem(){
                      Row(){
                        Text(announce.name)
                          .width('70%')
                          .fontSize(25)
                          .fontWeight(FontWeight.Bold)
                        Text(announce.time)
                          .width('80%')
                          .fontSize(20)
                          .fontWeight(FontWeight.Bold)
                          .padding({top:40})
                      }
                      .width('100%')
                      .height(120)
                      //.padding({left:14, right:14})
                      .backgroundColor('#fff')
                      .borderRadius(10)
                      .onClick(()=>{
                        //跳转公告详情页
                        router.pushUrl({
                          url:'pages/Announcement',
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
                    }
                  })
              }
              .padding({left:10,right:10,top:10})
              .layoutWeight(1)
          }.width('100%').height('100%').backgroundColor('#eee')
        }

      }
        .tabBar(this.TabBuilder('首页',0,$r('app.media.shouye'),$r('app.media.shouyeselect')))

        //page2-工作台界面
        TabContent() {
          Column(){
            //headline
            Row(){
              Text('OA 办公系统')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor('#00BFFF')
                .margin({left:100})
            }
            .backgroundColor(Color.White)
            .width('100%')
            //签到，考勤
            Row({space:20}){
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
                  .width('45%')
                  .height(100)
                  .type(ButtonType.Normal)
                  .backgroundColor('#1E90FF')
                Button('签到')
                  .onClick(()=>{
                    //跳转到签到界面
                    router.pushUrl({
                      url:'pages/SignIn',
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
                  .width('45%')
                  .height(100)
                  .type(ButtonType.Normal)
                  .backgroundColor('#1E90FF')
            }
            .height(150)
            //事务管理
            Row() {
              Column({space:20}) {
                Text('事务管理')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 30 })
                  .width('100%')
                Row({space:20}){
                  Column() {
                   Image($r('app.media.qingjiaxiaojia'))
                     .width(40)
                     .height(40)
                     .margin({left:25,top:10})
                     .onClick(()=>{
                       //跳转到请假界面
                     })
                   Text('请假')
                     .width(40)
                     .margin({left:30})
                 }
                  Column() {
                    Image($r('app.media.chuchai'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到出差界面
                      })
                    Text('出差')
                      .width(40)
                      .margin({left:30})
                  }
                  Column() {
                    Image($r('app.media.waichu'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到外出界面
                      })
                    Text('外出')
                      .width(40)
                      .margin({left:30})
                  }
                  Column() {
                    Image($r('app.media.buka'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
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
                      .width(40)
                      .margin({left:30})
                  }
                }.width('100%')
                .height(50)
                Row({space:20}){
                  Column() {
                    Image($r('app.media.huiyishenqing'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到会议申请界面
                      })
                    Text('会议申请')
                      .width(80)
                      .margin({left:30})
                  }.margin({left:-20})
                  Column() {
                    Image($r('app.media.jiaban'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到加班界面
                      })
                    Text('加班')
                      .width(40)
                      .margin({left:30})
                  }.margin({left:-20})
                  Column() {
                    Image($r('app.media.baoxiao'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到报销界面
                      })
                    Text('报销')
                      .width(40)
                      .margin({left:30})
                  }
                }.width('100%')
              }
            }
            //人事管理
            Row(){
              Column({space:20}){
                Text('人事管理')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 30 })
                  .width('100%')
                  .padding({top:20})
                Row({space:20}){
                  Column() {
                    Image($r('app.media.zhuanzheng'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到转正界面
                      })
                    Text('转正')
                      .width(40)
                      .margin({left:30})
                  }
                  Column() {
                    Image($r('app.media.tiaogang'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到调岗界面
                      })
                    Text('调岗')
                      .width(40)
                      .margin({left:30})
                  }
                  Column() {
                    Image($r('app.media.lizhi'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到离职界面
                      })
                    Text('离职')
                      .width(40)
                      .margin({left:30})
                  }
                }.width('100%')
              }
            }
            //其他
            Row(){
              Column({space:20}){
                Text('其他')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 40 })
                  .width('100%')
                  .padding({top:20})
                Row({space:20}){
                  Column() {
                    Image($r('app.media.daibanshixiang'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
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
                      .margin({left:30})
                  }.margin({left:-20})
                  Column() {
                    Image($r('app.media.shenpi'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
                      .onClick(()=>{
                        //跳转到审批中心界面
                      })
                    Text('审批中心')
                      .width(80)
                      .margin({left:30})
                  }.margin({left:-40})
                  Column() {
                    Image($r('app.media.gonggao'))
                      .width(40)
                      .height(40)
                      .margin({left:25,top:10})
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
                      .margin({left:30})
                  }.margin({left:-40})
                }.width('100%')
              }
            }
          }.width('100%').height('100%').backgroundColor('#eee')
        }
        .tabBar(this.TabBuilder('工作台',1,$r('app.media.Workbench'),$r('app.media.Workbenchselect')))

        //page3-我的界面
        TabContent() {
          Column(){
            Row(){
              Image($r('app.media.geren'))
                .width(40)
                .margin({left:80})
              Text('个人信息')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({left:10})
            }
            .backgroundColor(Color.White)
            .width('100%')
            //读取后端数据 this.name？？
            Row(){
              Text('姓名')
                .fontSize(25)
                .margin({left:20})
              Text('巫山云')
                .fontSize(18)
                .margin({left:200})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            Row(){
              Text('性别')
                .fontSize(25)
                .margin({left:20})
              Text('男')
                .fontSize(18)
                .margin({left:200})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            Row(){
              Text('生日')
                .fontSize(25)
                .margin({left:20})
              Text('2024/5/24')
                .fontSize(18)
                .margin({left:200})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            Row(){
              Text('职位')
                .fontSize(25)
                .margin({left:20})
              Text('经理')
                .fontSize(18)
                .margin({left:200})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            Row(){
              Text('电话')
                .fontSize(25)
                .margin({left:20})
              Text('18853820296')
                .fontSize(18)
                .margin({left:150})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            .justifyContent(FlexAlign.SpaceBetween)
            Row(){
              Text('部门')
                .fontSize(25)
                .margin({left:20})
              Text('运营部')
                .fontSize(18)
                .margin({left:200})
            }.width('100%')
            .height(50)
            .backgroundColor('#fff')
            .margin({top:20})
            .borderRadius(20)
            Row(){
              Image($r('app.media.xiugai'))
                .width(20)
              Text('修改密码')
                .fontColor(Color.Blue)
            }.width('100%')
            .margin({top:20})
            .justifyContent(FlexAlign.End)
            .borderColor(Color.Blue)
            .onClick(()=>{
              this.dialogController.open()
            })

            Button() {
              Row() {
                Image($r('app.media.tuichu'))
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
            .margin({top:80})
            .backgroundColor('#ea6363')
          }.width('100%').height('100%').backgroundColor('#eee')
        }
        .tabBar(this.TabBuilder('我的',2,$r('app.media.wode'),$r('app.media.wodeselect')))
        
    }
      .barWidth('100%') // 设置TabBar宽度
      .barHeight(60) // 设置TabBar高度
      .width('100%') // 设置Tabs组件宽度
      .height('100%') // 设置Tabs组件高度
      .backgroundColor(0xF5F5F5)
  }
}
@CustomDialog     //修改密码弹窗
struct PasswordDialog {
  controller: CustomDialogController
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
            this.newPassword = value
            console.log(this.newPassword)
          })
      }
      Button('确认').margin({top:30})
        .fontSize(20)
        .onClick((value)=>{
          this.controller.close()
        })
    }.height(150).width('90%')
  }
}