@Entry
@Component
struct Login {

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
        }
        .height(60)
        .width(300)

        Row() {
          Text('提交入职申请')
            .onClick(()=>{
              //跳转到入职申请界面
            })
        }
        .height(30)
        .padding({left:150})
        Row() {
          Button('登录')
            .width(120)
            .onClick(() => {
              //登录操作成功则跳转到首页
            })
        }
        .height(80)
      }
    .height('100%')
    .backgroundColor('#43AAEA')
  }
}