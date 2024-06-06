import http from '@ohos.net.http';
import {OverTimeInfo,OverTimeResponse,OverTimeData} from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class OvertimeModel {
  baseURL: string = 'http://172.16.24.50:8080';


  // 根据用户id查看自己的加班申请
  async getOvertimeById(employeeId: number) {
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/getOverById/${id}`,
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
          reject('获取个人加班申请失败');
        }
      }).catch(error => {
        console.log('获取个人加班申请失败：', JSON.stringify(error));
        reject('获取个人加班申请失败');
      });
    });
  }
  // 查看未审批的加班申请
  async getNoReviewOvertime() {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewOvertime`,
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
          reject('获取未审批的加班申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的加班申请失败：', JSON.stringify(error));
        reject('获取未审批的加班申请失败');
      });
    });
  }

  // 审批加班申请
  async overtimeReview(overtimeId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/overtimeReview/${overtimeId}/${approverId}/${isApproved}`,
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
        console.log('审批加班申请失败：', JSON.stringify(error));
        reject('审批加班申请失败');
      });
    });
  }
}

const overtimeModel = new OvertimeModel();
export default overtimeModel;
