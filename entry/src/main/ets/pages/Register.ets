import router from '@ohos.router'
@Entry
@Component
struct Register {

  @State name:string = ''   //姓名
  @State department: string = ''   //部门
  @State job :string = ''  //职位
  @State number :string = ''  //手机号
  @State idcard :string = ''  //身份证号
  @State birthday:Date = new Date //生日
  @State isemployee:number = 0   //是否为正式员工
  @State intime:Date = new Date //入职时间
  @State account:string = ''  //账号
  @State password:string = '' //密码
  @State permission:number = 0  //权限

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
          Text('注册')
            .fontSize(30)
            .margin({ top: 10 })
            //姓名，部门，职位，手机号，身份证号，生日，是否为正式员工，入职时间，账号密码，权限
        }.width('100%').backgroundColor('#fff').height(50)
        Text('个人信息')
          .fontSize(25)
          .margin({top:20})
          .width('90%')
        Column(){
          Row(){
            Text('姓名').fontSize(20).margin({right:30})
            TextInput({placeholder:'输入姓名'}).width('60%').backgroundColor('#bec1d1')
              .onChange(value=>{
                this.name = value
                console.info('姓名: '+this.name)
              })
          }.margin({top:20})
          Row(){
            Text('职位').fontSize(20).margin({right:30})
            TextInput({placeholder:'输入职位'}).width('60%').backgroundColor('#bec1d1')
              .onChange(value=>{
                this.job = value
                console.info('职位: '+this.job)
              })
          }.margin({top:20})
          Row(){
            Text('手机号').fontSize(20).margin({right:15})
            TextInput({placeholder:'输入手机号'}).width('60%').backgroundColor('#bec1d1')
              .onChange(value=>{
                this.number = value
                console.info('手机号: '+this.number)
              })
          }.margin({top:20})
          Row(){
            Text('身份证号').fontSize(20).margin({right:10})
            TextInput({placeholder:'输入身份证号'}).width('60%').backgroundColor('#bec1d1')
              .onChange(value=>{
                this.idcard = value
                console.info('身份证号: '+this.idcard)
              })
          }.margin({top:20,right:10})
          Row(){
            Button('选择部门', { type: ButtonType.Capsule, stateEffect: false })
              .backgroundColor('#6CA6CD')
              .width(120)
              .bindMenu([{
                value: '销售部',
                action: () => {
                  this.department = '销售部'
                  console.info(this.department)
                }
              },
                {
                  value: '技术部',
                  action: () => {
                    this.department = '技术部'
                    console.info(this.department)
                  }
                },
                {
                  value: '人力资源部',
                  action: () => {
                    this.department = '人力资源部'
                    console.info(this.department)
                  }
                },
                {
                  value: '财政部',
                  action: () => {
                    this.department = '财政部'
                    console.info(this.department)
                  }
                },
                {
                  value: '营销部',
                  action: () => {
                    this.department = '营销部'
                    console.info(this.department)
                  }
                },]
              )
            Button('选择生日').width('40%')
              .backgroundColor('#6CA6CD')
              .width(120)
              .margin({left:20})
              .onClick((value)=> {
                DatePickerDialog.show({
                  start: new Date("1900-1-1"),
                  end: new Date("2030-12-31"),
                  selected: this.birthday,
                  onAccept: (value: DatePickerResult) => {
                    // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                    this.birthday.setFullYear(value.year, value.month, value.day)
                    console.info("生日: " + this.birthday)
                  }
                })
              })
          }.margin({top:20})
          Row(){
            Button('是否转正', { type: ButtonType.Capsule, stateEffect: false })
              .backgroundColor('#6CA6CD')
              .width(120)
              .bindMenu([{
                  value: '是',
                  action: () => {
                    this.isemployee = 1
                    console.log(this.isemployee.toString())
                  }
                },
                {
                  value: '否',
                  action: () => {
                    this.isemployee = 0
                    console.log(this.isemployee.toString())
                  }
                },]
              )

            Button('入职时间').width('40%')
              .width(120)
              .margin({left:20})
              .backgroundColor('#6CA6CD')
              .onClick((value)=> {
                DatePickerDialog.show({
                  start: new Date("2000-1-1"),
                  end: new Date("2030-12-31"),
                  selected: this.intime,
                  onAccept: (value: DatePickerResult) => {
                    // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                    this.intime.setFullYear(value.year, value.month, value.day)
                    console.info("入职时间: " + this.intime)
                  }
                })
              })
          }.margin({top:20})
        }.backgroundColor('#fff').width('100%').height('45%').borderRadius(30).margin({top:10})
        Text('账号信息')
          .fontSize(25)
          .margin({top:30})
          .width('90%')
        Column(){
          Row(){
            Text('账号').fontSize(20).margin({right:30})
            TextInput({placeholder:'输入账号'}).width('60%').backgroundColor('#bec1d1')
              .onChange(value=>{
                this.account = value
                console.info('账号: '+this.account)
              })
          }.margin({top:20})
          Row(){
            Text('密码').fontSize(20).margin({right:30})
            TextInput({placeholder:'输入密码'}).width('60%').backgroundColor('#bec1d1').type(InputType.Password)
              .onChange(value=>{
                this.password = value
                console.info('密码: '+this.password)
              })
          }.margin({top:20})
          Button('是否转正', { type: ButtonType.Capsule, stateEffect: false })
            .backgroundColor('#6CA6CD')
            .width(120)
            .margin({top:20,right:150})
            .bindMenu([{
              value: '管理员',
              action: () => {
                this.permission = 1
                console.log(this.permission.toString())
              }
            },
              {
                value: '普通员工',
                action: () => {
                  this.permission = 0
                  console.log(this.permission.toString())
                }
              },]
            )
        }.backgroundColor('#fff').width('100%').height('25%').borderRadius(30).margin({top:10})
        Button('注册')
          .margin({top:10})
          .width(100)
          .onClick((value)=>{
            router.back()
          })
      }
      .width('100%').height('100%').backgroundColor('#F1F2F3')
  }
}