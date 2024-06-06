import http from '@ohos.net.http';
import {ReimburseResponse,ReimburseInfo,ReimburseData} from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class ReimbursementModel {
  private baseURL: string = 'http://172.16.24.50:8080';

  // 根据员工id查询报销申请表
  public async getReimbursementById(employeeId: number) {
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/getResignationById/${id}`,
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
          reject('获取个人报销申请失败');
        }
      }).catch(error => {
        console.log('获取个人报销申请失败：', JSON.stringify(error));
        reject('获取个人报销申请失败');
      });
    });
  }

  // 查询未审批的报销申请
   async getNoReviewReimbursement() {
    return new Promise ((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReimburse`,
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
          reject('获取未审批的报销申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的报销申请失败：', JSON.stringify(error));
        reject('获取未审批的报销申请失败');
      });
    });
  }

  // 审批报销申请
  async reimbursementReview(reimbursementId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/resignationReview/${reimbursementId}/${approverId}/${isApproved}`,
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
        console.log('审批报销申请失败：', JSON.stringify(error));
        reject('审批报销申请失败');
      });
    });
  }
}

const reimbursementModel = new ReimbursementModel();
export default reimbursementModel;
