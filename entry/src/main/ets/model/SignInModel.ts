import PreferencesUtil from '../util/preferencesUtil';
import http from '@ohos.net.http';
import SignInInfo,{SignInResponse,SignOutResponse} from '../viewmodel/SignInInfo'

class SignInModel {
  baseURL: string = 'http://172.16.24.50:8080';
  async SignInRequest(signInResponse:SignInResponse) {

    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const year = signInResponse.sign_in_time.getFullYear();
    const month = (signInResponse.sign_in_time.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = signInResponse.sign_in_time.getDate().toString().padStart(2, '0');
    const hours = signInResponse.sign_in_time.getHours().toString().padStart(2, '0');
    const minutes = signInResponse.sign_in_time.getMinutes().toString().padStart(2, '0');

    console.log('employee_id:', id)
    const requestBody = {
      employee_id:id,
      sign_in_time:`${year}-${month}-${day} ${hours}:${minutes}:00`
    };

    console.log('发送的请求体：', JSON.stringify(requestBody).toString());


    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/signIn`,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          if (result.code === 1) {
            resolve(result.data);
          } else {
            console.log('请求成功但响应有误', result);
            reject('签到失败');
          }
        } else {
          console.log('http--失败1', resp.result);
          reject('签到失败');
        }
      }).catch(error => {
        console.log('签到失败error(catch):', JSON.stringify(error));
        reject('签到失败');
      })
    })
  }
  async SignOutRequest(signOutResponse: SignOutResponse) {
    let id = await PreferencesUtil.getPreferenceValue('User', 'employee_id', 0) as number;
    const year = signOutResponse.sign_out_time.getFullYear();
    const month = (signOutResponse.sign_out_time.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = signOutResponse.sign_out_time.getDate().toString().padStart(2, '0');
    const hours = signOutResponse.sign_out_time.getHours().toString().padStart(2, '0');
    const minutes = signOutResponse.sign_out_time.getMinutes().toString().padStart(2, '0');

    console.log('employee_id:', id);

    // 构建 requestBody 对象
    const requestBody = {
      employee_id: id,
      sign_out_time: `${year}-${month}-${day} ${hours}:${minutes}:00`
    };

    // 发送请求并处理响应
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/signOut`,
        {
          method: http.RequestMethod.PUT,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          if (result.code === 1) {
            resolve(result.data);
          } else {
            console.log('请求成功但响应有误', result);
            reject('签退失败');
          }
        } else {
          console.log('http--失败1', resp.result);
          reject('签退失败');
        }
      }).catch(error => {
        console.log('签退失败error(catch):', JSON.stringify(error));
        reject('签退失败');
      });
    });
  }



}
const signInModel = new SignInModel();
export default signInModel;
