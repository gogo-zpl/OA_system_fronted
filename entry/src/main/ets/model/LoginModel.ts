import {loginInfo} from '../viewmodel/LoginInfo'
import LoginResponse from '../viewmodel/LoginInfo'
import http from '@ohos.net.http'



class LoginModel{
  //baseURL:string = 'http://172.16.24.10:8080'
  baseURL:string = 'http://172.16.24.50:8080'

  LoginRequest(loginInfo:loginInfo) {
    const requestBody = {
      account: loginInfo.account,
      password: loginInfo.password,
      permission:loginInfo.permission
    }
    console.log('发送的请求体：', JSON.stringify(requestBody).toString())

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseURL}/login`,
        {
          method:http.RequestMethod.POST,
          extraData:JSON.stringify(requestBody)
        }
      ).then(resp=>{
        if(resp.responseCode === 200){
          //查询成功
          console.log('http--成功',resp.result)
          const result = JSON.parse(resp.result.toString()) as LoginResponse
          resolve(result)
          console.info(JSON.stringify(requestBody).toString())
        }else{
          console.log('http--失败1',resp.result)
          console.info('http--失败2',JSON.stringify(requestBody).toString())
          reject('登录失败')
        }
      }).catch(
        error => {
          console.info('登录失败error(catch):' + JSON.stringify(error))
          reject('登录失败')
        }
      )
    })
  }
}
const loginModel = new LoginModel()
export default loginModel