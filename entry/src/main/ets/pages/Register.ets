import router from '@ohos.router'
import Title from '../components/title/Title'
import RegisterInfo,{RegisterResponse} from'../viewmodel/RegisterInfo'
import RegisterModel from '../model/RegisterModel'
@Entry
@Component
struct Register {
  private registerInfo: RegisterInfo = {
    name: '',
    department_name: '',
    account: '',
    password: '',
    position: '',
    phone_number: '',
    birthday: new Date(),
    id_card: '',
    hire_date: new Date()
  }

  //注册函数
  register(){
    RegisterModel.RegisterRequest(this.registerInfo)
      .then((message:RegisterResponse) => {
        if (message.code === 1) {
          router.back()
          console.log('Data:', message.data)
        }else{
          console.log('注册失败');
        }
      })
      .catch(error => {
        console.log(error)
      })
  }
  build() {
    Column() {
      Title({ pageTitle: '注册' })

      Text('个人信息')
        .fontSize(25)
        .fontWeight(700)
          //.fontColor('333399')
        .fontColor('balck')
        .margin({left:20,top:20})
        .width('90%')
      //###########################################
      Column(){
        Row(){
          Text('姓名').fontSize(20).margin({right:30})
          TextInput({placeholder:'输入姓名'}).width('60%').backgroundColor('#B2DFEE')
            .onChange(value=>{
              this.registerInfo.name = value
              console.info('姓名: '+this.registerInfo.name)
            })
        }.margin({top:20})

        Row(){
          Text('职位').fontSize(20).margin({right:30})
          TextInput({placeholder:'输入职位'})
            .width('60%')
            .backgroundColor('#B2DFEE')
            .onChange(value=>{
              this.registerInfo.position = value
              console.info('职位: '+this.registerInfo.position)
            })
        }.margin({top:20})
        Row(){
          Text('手机号').fontSize(20).margin({right:15})
          TextInput({placeholder:'输入手机号'}).width('60%').backgroundColor('#B2DFEE')
            .onChange(value=>{
              this.registerInfo.phone_number = value
              console.info('手机号: '+this.registerInfo.phone_number)
            })
        }.margin({top:20})
        Row(){
          Text('身份证号').fontSize(20).margin({right:10})
          TextInput({placeholder:'输入身份证号'}).width('60%').backgroundColor('#B2DFEE')
            .onChange(value=>{
              this.registerInfo.id_card = value
              console.info('身份证号: '+this.registerInfo.id_card)
            })
        }.margin({top:20,right:10})
        Row(){
          Button('选择部门', { type: ButtonType.Capsule, stateEffect: false })
            .backgroundColor('#6CA6CD')
            .width(120)
            .bindMenu([{
              value: '销售部',
              action: () => {
                this.registerInfo.department_name = '销售部'
                console.info(this.registerInfo.department_name)
              }
            },
              {
                value: '技术部',
                action: () => {
                  this.registerInfo.department_name = '技术部'
                  console.info(this.registerInfo.department_name)
                }
              },
              {
                value: '人力资源部',
                action: () => {
                  this.registerInfo.department_name = '人力资源部'
                  console.info(this.registerInfo.department_name)
                }
              },
              {
                value: '财政部',
                action: () => {
                  this.registerInfo.department_name = '财政部'
                  console.info(this.registerInfo.department_name)
                }
              },
              {
                value: '营销部',
                action: () => {
                  this.registerInfo.department_name = '营销部'
                  console.info(this.registerInfo.department_name)
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
                selected: this.registerInfo.birthday,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.registerInfo.birthday.setFullYear(value.year, value.month, value.day)
                  console.info("生日: " + this.registerInfo.birthday)
                }
              })
            })
        }.margin({top:20})
        Row(){

          Button('入职时间')
            .width('40%')
            .width(265)
              // .margin({right:140})
            .backgroundColor('#6CA6CD')
            .onClick((value)=> {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2030-12-31"),
                selected: this.registerInfo.hire_date,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.registerInfo.hire_date.setFullYear(value.year, value.month, value.day)
                  console.info("入职时间: " + this.registerInfo.hire_date)
                }
              })
            })
        }.margin({top:20})
      }//1colu
      .backgroundColor('#fff').width('100%').height('45%').borderRadius(30).margin({top:10})
      .width('90%')

      //###########################################
      Text('账号信息')
        .fontSize(25)
        .fontWeight(700)
        .fontColor('black')
          //.fontColor($r('app.color.font_main'))
        .margin({left:20,top:20})
        .width('90%')

      Column(){
        Row(){
          Text('账号').fontSize(20).margin({right:30})
          TextInput({placeholder:'输入账号'}).width('60%').backgroundColor('#B2DFEE')
            .onChange(value=>{
              this.registerInfo.account = value
              console.info('账号: '+this.registerInfo.account)
            })
        }.margin({top:20})
        Row(){
          Text('密码').fontSize(20).margin({right:30})
          TextInput({placeholder:'输入密码'}).width('60%').backgroundColor('#B2DFEE').type(InputType.Password)
            .onChange(value=>{
              this.registerInfo.password = value
              console.info('密码: '+this.registerInfo.password)
            })
        }.margin({top:20})

      }//colu2
      .backgroundColor('#fff').width('100%').height('18%').borderRadius(30).margin({top:10})
      .width('90%')

      Button('注册')
        .margin({top:30})
        .width(100)
        .onClick((value)=>{
          //router.back()
          this.register()
        })
    }//大colu
    .width('100%').height('100%')
    .backgroundColor('#F0F8FF')
    //.backgroundColor('#F1F2F3')
  }//build
}//struct