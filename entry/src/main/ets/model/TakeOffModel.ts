import http from '@ohos.net.http';
import TakeOffInfo from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class TakeOffModel {
  private baseURL: string = 'http://172.16.24.50:8080';

  public async getTakeOffById(employeeId: number){
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/getTake_offById/${id}`,
        {
          method: http.RequestMethod.GET
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          resolve(result.data);
        } else {
          console.log('http--失败', resp.result);
          reject('获取个人请假申请失败');
        }
      }).catch(error => {
        console.log('获取个人请假申请失败：', JSON.stringify(error));
        reject('获取个人请假申请失败');
      });
    });
  }

  // 查询未审批的请假申请
  public async getNoReviewTakeOff(){
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewTake_off`,
        {
          method: http.RequestMethod.GET
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          resolve(result.data);
        } else {
          console.log('http--失败', resp.result);
          reject('获取未审批的请假申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的请假申请失败：', JSON.stringify(error));
        reject('获取未审批的请假申请失败');
      });
    });
  }

  // 审批请假申请
  public async takeOffReview(takeOffId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/Take_offReview/${takeOffId}/${approverId}/${isApproved}`,
        {
          method: http.RequestMethod.PUT
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString());
          resolve(result.data);
        } else {
          console.log('http--失败', resp.result);
          reject('审批失败');
        }
      }).catch(error => {
        console.log('审批请假申请失败：', JSON.stringify(error));
        reject('审批请假申请失败');
      });
    });
  }
}

const takeOffModel = new TakeOffModel();
export default takeOffModel;
