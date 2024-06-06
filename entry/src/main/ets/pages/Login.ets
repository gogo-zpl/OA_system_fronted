import router from '@ohos.router';
import LoginResponse, { EmployeeData,loginInfo }  from '../viewmodel/LoginInfo'
import LoginModel from '../model/LoginModel'
import PreferencesUtil from '../util/preferencesUtil'
@CustomDialog     //登录错误弹窗
struct PasswordDialog {
  controller: CustomDialogController
  build() {
    Column() {
      Row() {
        Text('账号或密码错误').margin({ top: 20 })
          .fontSize(20)
      }
      Button('确认').margin({ top: 20 })
        .fontSize(20)
        .onClick((value) => {
          this.controller.close()
        })
    }
  }
}

@Entry
@Component
struct Login {
  private loginInfo:loginInfo ={account:'',password:'',permission:0}
  //登录失败弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: PasswordDialog({}),
  })
  @State loggedInUser: EmployeeData | null = null //保存用户数据

  login() {   //登录判断
      LoginModel.LoginRequest(this.loginInfo)
      .then((message:LoginResponse) => {
        if (message.code === 1) {
        this.loggedInUser= message.data; // 获取返回数据中的 EmployeeData 对象
          //数据持久化（用户id）写入
          PreferencesUtil.putPreferenceValue('User','employee_id',this.loggedInUser.employee_id)
          const birthdateString = this.loggedInUser.birthdate.toString();
          router.pushUrl({
          url: 'pages/Index',
          params: {
            employee_id:this.loggedInUser.employee_id,
            name:this.loggedInUser.name,
            department_id: this.loggedInUser.department_id,
            position:this.loggedInUser.position,
            phone_number:this.loggedInUser.phone_number,
            id_card: this.loggedInUser.id_card,
            birthdate:birthdateString,
            is_regular_employee:this.loggedInUser.is_regular_employee,
            hire_date:this.loggedInUser.hire_date,
            password: this.loggedInUser.password,
            account: this.loggedInUser.account,
            permission: this.loggedInUser.permission,
            department_name: this.loggedInUser.department_name }
        }, router.RouterMode.Single, err => {
          if (err) {
            console.log('路由失败');
          }
        })
          console.log('Name:', this.loggedInUser.birthdate.toString())
      }else{
          console.log('登录失败');
          this.dialogController.open()
        }
      })
      .catch(error => {
        console.log(error)
      })
  }

  build() {
      Column() {
        Row() {
          Image('https://ts1.cn.mm.bing.net/th/id/R-C.bd8426ec27ee621aaeaa219fa20ab9b6?rik=2B0D3DDZUXLIkg&riu=http%3a%2f%2fpic.iresearch.cn%2fnews%2f201907%2fc0f0f41f-50b1-4d5c-b382-1d0689ddd9fd.jpeg&ehk=bhJOB5UzYy8qK0T5dqR6icf5ff7%2f1pkfEINaSNWZOPk%3d&risl=&pid=ImgRaw&r=0')
            .width(360)
            .height(250)
        }
        .width('100%')
        .height(400)
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('账号  ')
            .width(40)
            .height(40)
          TextInput({ placeholder: '请输入账号或手机号' })
            .onChange(value=>{
              this.loginInfo.account=value
            })
            //读取输入结果的操作
            .width(250)
            .height(40)
            .backgroundColor('#FFF')
        }.width(300)

        Row() {
          Text('密码  ')
            .width(40)
            .height(40)
          TextInput({ placeholder: '请输入密码' })
            //读取输入结果的操作
            .width(250)
            .height(40)
            .backgroundColor('#FFF')
            .type(InputType.Password)
            .onChange(value=>{
              this.loginInfo.password=value
            })
        }
        .height(60)
        .width(300)

        Row() {
          Text('注册')
            .onClick(()=>{
              //跳转到注册界面
              router.pushUrl({
                url:'pages/Register',
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
        .height(30)
        .padding({left:220})
        Row() {
          Button('登录')
            .width(120)
            .onClick(() => {
              //登录操作成功则跳转到首页
             this.login()
            })
        }
        .height(80)
      }
    .height('100%')
    .backgroundColor('#43AAEA')
  }
}
