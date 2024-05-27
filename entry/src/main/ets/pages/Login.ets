import router from '@ohos.router';
@Entry
@Component
struct Login {
  @State account:string = ''  //获取账号
  @State password:string = ''  //获取密码
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
            this.account = value
              //console.log(this.account)
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
              this.password = value
              //console.log(this.password)
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
              router.pushUrl({
                url:'pages/Index',
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
        .height(80)
      }
    .height('100%')
    .backgroundColor('#43AAEA')
  }
}