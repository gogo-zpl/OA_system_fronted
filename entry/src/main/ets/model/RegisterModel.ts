import http from '@ohos.net.http';
import ChangePasswordInfo from '../viewmodel/ChangePasswordInfo';
import RegisterInfo,{RegisterResponse} from '../viewmodel/RegisterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class RegisterModel {
  baseURL: string = 'http://172.16.24.50:8080';

  RegisterRequest(registerInfo: RegisterInfo) {
    const requestBody = {
      name: registerInfo.name,
      department_name: registerInfo.department_name,
      account: registerInfo.account,
      password: registerInfo.password,
      position: registerInfo.position,
      phone_number: registerInfo.phone_number,
      birthdate: registerInfo.birthday.toISOString().split('T')[0],
      id_card: registerInfo.id_card,
      hire_date: registerInfo.hire_date.toISOString().split('T')[0]
    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/register`,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString()) as RegisterResponse
          resolve(result);
        } else {
          console.log('http--失败1', resp.result);
          reject('注册失败');
        }
      }).catch(error => {
        console.log('注册失败error(catch):', JSON.stringify(error));
        reject('注册失败');
      });
    });
  }

 async  ChangePasswordRequest(changePasswordInfo: ChangePasswordInfo) {
    const requestBody = {
      newPassword: changePasswordInfo.newPassword
    };
    let employee_id = changePasswordInfo.id
    employee_id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number

    console.log('发送的请求体：', JSON.stringify(requestBody).toString());

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/emps/${employee_id}/${changePasswordInfo.newPassword}`,
        {
          method: http.RequestMethod.PUT,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString());
          resolve(result);
        } else {
          console.log('http--失败1', resp.result);
          reject('修改密码失败');
        }
      }).catch(error => {
        console.log('修改密码失败error(catch):', JSON.stringify(error));
        reject('修改密码失败');
      });
    });
  }


}

const registerModel = new RegisterModel();
export default registerModel;
