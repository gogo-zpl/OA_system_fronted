import http from '@ohos.net.http';
import {LeaveInfo,LeaveResponse,LeaveData} from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class LeaveModel {
  baseURL: string = 'http://172.16.24.50:8080';

  // 查看个人请假申请
  async getLeaveById(employeeId: number){
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/getLeaveById/${id}`,
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
  // 查看未审批的出差申请
  async getNoReviewLeave() {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewLeave`,
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
          reject('获取未审批的出差申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的出差申请失败：', JSON.stringify(error));
        reject('获取未审批的出差申请失败');
      });
    });
  }

  // 审批请假申请
  async leaveReview(leaveId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/LeaveReview/${leaveId}/${approverId}/${isApproved}`,
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

const leaveModel = new LeaveModel();
export default leaveModel;
