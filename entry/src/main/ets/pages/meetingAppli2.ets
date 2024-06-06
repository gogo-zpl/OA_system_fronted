import http from '@ohos.net.http';
import Title from '../components/title/Title'
import PreferencesUtil from '../util/preferencesUtil'
import { Meeting } from '../viewmodel/meeting'
import {MeetingItem} from '../pages/seeingMeeting'

@Entry
@Component
struct meetingAppli2{

  @State meetings: Array<Meeting> = []; // 假设Meeting是会议申请的数据类型
  baseUrl:string = 'http://172.16.24.50:8080'

  async idMeetingRequest() {
    // 构建请求体
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseUrl}/getById/${id}`,
        {
          method:http.RequestMethod.GET,
          // header:{
          //   'Content-Type': 'application/json'
          // },
          connectTimeout:20000,
          readTimeout:20000
        }
      ).then(resp=>{
        if(resp.responseCode === 200){

          const result=JSON.parse(resp.result.toString())
          if(result.code===1&&result.msg==="success"){
            this.meetings = result.data
          }
          //查询成功
          console.log('http--成功get meetingappli2',this.meetings.toString())
          resolve(JSON.parse(resp.result.toString()))
        }else{
          console.log('http--get失败1',resp.result)
          console.info('http--get失败2',JSON.stringify(resp).toString())
          reject('申请失败')
        }//else
      }).catch(
        error => {
          console.info('发送申请失败error(catch):'+JSON.stringify(error))
          reject('发送申请失败')
        }
      ) //request
    })
  }//submitMeetingRequest()

aboutToAppear(){
  this.idMeetingRequest()
}

  build(){

    Column() {
      Title({ pageTitle: '我的会议申请' })
      Divider().color($r('app.color.line_grey'))
      List({space:10}){
        ForEach(this.meetings,onemeeting=>{
          ListItem(){
            MeetingItem({meeting: onemeeting})
          }
        })
      }
    }


  }
}