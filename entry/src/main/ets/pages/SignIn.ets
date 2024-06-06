import router from '@ohos.router';
import Title from '../components/title/Title'
import systemDateTime from '@ohos.systemDateTime';
import SignInModel from '../model/SignInModel';
import SignInInfo, { SignInResponse, SignOutResponse } from '../viewmodel/SignInInfo';
let employee_name = router.getParams()['employee_name']
@Entry
@Component
struct SignIn {
  @State signin: number = -1;
  @State signin_time: string = '';
  @State signout_time: string = '';
  private signInResponse: SignInResponse = {
    employee_id: 0,
    sign_in_time: new Date()
  };
  private signOutResponse: SignOutResponse = {
    employee_id: 0,
    sign_out_time: new Date()
  };
  private lastSignDate: string = '';

  build() {
    Column() {
      Column(){
        Title({ pageTitle: '签到' })
        Divider().color($r('app.color.line_grey'))
      }.opacity(0.7)



      Row() {
        Button('签到')
          .backgroundColor('#36648b')
          .opacity(0.8)
          .type(ButtonType.Circle)
          .width(130)
          .margin({ top: 80 })
          .fontSize(30)
          .onClick(() => {
            if (this.canSignIn()) {
              this.doSignIn();
            } else {
              console.log('今天已经签到过了');
            }
          });
        Button('签退')
          .type(ButtonType.Circle)
          .backgroundColor('#36648b')
          .opacity(0.8)
          .width(130)
          .margin({ top: 80, left: 50 })
          .fontSize(30)
          .onClick(() => {
            this.doSignOut();
          });
      }

      //考勤状态表
      Row() {
        Column() {
          Text('考勤状态表').fontWeight(FontWeight.Bold).margin({ right: 10, top: 8 ,bottom:10}).fontSize(20).fontColor('black')
          Divider().color($r('app.color.font_normal'))
          Column({ space: 10 }) {
            if (this.signin == -1) {
              Text('状态: ').fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('签到时间: ').fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('签退时间: ').fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('操作人: ' + employee_name).fontSize(18).margin({ left: 20 ,bottom:25})
                .fontWeight('600').fontColor('black')
            }
            else if (this.signin === 0) {
              Text('状态: 已签到').fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('签到时间: ' + this.signin_time).fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('操作人: ' + employee_name).fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('    ')
            } else if (this.signin === 1) {
              Text('状态: 已完成今日考勤').fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('签退时间: ' + this.signout_time).fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('操作人: ' + employee_name).fontSize(18).margin({ left: 20 })
                .fontWeight('600').fontColor('black')
              Text('    ')
            }
          }.margin({ top: 30 })
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }
      }
      .opacity(0.6)
      .borderRadius(20)
      .margin({ top: 150 })
      .width('90%')
      .height(220)
      .backgroundColor('#ffffff');
    }
    .width('100%').height('100%')
    .opacity(1)
    .backgroundImage('/pages/img/dahai.jpg')
    .backgroundImageSize(ImageSize.Cover)
  }//build

  // 检查是否可以签到
  private canSignIn(): boolean {
    return this.lastSignDate !== getCurrentDate();
  }

  // 检查是否可以签退
  private canSignOut(): boolean {
    return this.signin === 0 && this.lastSignDate === getCurrentDate();
  }

  // 执行签到操作
  private doSignIn() {
    SignInModel.SignInRequest(this.signInResponse)
      .then(() => {
        this.signin = 0;
        this.signin_time = getFormattedDateTime(this.signInResponse.sign_in_time);
        this.lastSignDate = getCurrentDate();
        console.log('签到成功');
      })
      .catch(error => {
        console.error('签到失败:', error);
      });
  }

  // 执行签退操作
  private doSignOut() {
    SignInModel.SignOutRequest(this.signOutResponse)
      .then(() => {
        this.signin = 1;
        this.signout_time = getFormattedDateTime(this.signOutResponse.sign_out_time);
        console.log('签退成功');
      })
      .catch(error => {
        console.error('签退失败:', error);
      });
  }
}

// 获取当前日期的格式化字符串
function getCurrentDate(): string {
  const today = new Date();
  return today.toISOString().split('T')[0];
}

// 格式化日期时间函数
function getFormattedDateTime(dateTime: Date): string {
  const year = dateTime.getFullYear();
  const month = (dateTime.getMonth() + 1).toString().padStart(2, '0');
  const day = dateTime.getDate().toString().padStart(2, '0');
  const hours = dateTime.getHours().toString().padStart(2, '0');
  const minutes = dateTime.getMinutes().toString().padStart(2, '0');
  const seconds = dateTime.getSeconds().toString().padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}