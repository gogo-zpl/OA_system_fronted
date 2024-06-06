import http from '@ohos.net.http';
import {ResignationInfo,ResignationResponse,ResignationData} from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil';

class ResignationModel {
  baseURL: string = 'http://172.16.24.50:8080';

  public async getResignationById(employeeId: number) {
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
          reject('获取离职申请失败');
        }
      }).catch(error => {
        console.log('获取离职申请失败：', JSON.stringify(error));
        reject('获取离职申请失败');
      });
    });
  }


  async getNoReviewResignations() {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewResignation`,
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
          reject('获取未审核的离职申请失败');
        }
      }).catch(error => {
        console.log('获取未审核的离职申请失败：', JSON.stringify(error));
        reject('获取未审核的离职申请失败');
      });
    });
  }

  async reviewResignation(resignationId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/resignationReview/${resignationId}/${approverId}/${isApproved}`,
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
        console.log('审批离职申请失败：', JSON.stringify(error));
        reject('审批离职申请失败');
      });
    });
  }
}

const resignationModel = new ResignationModel();
export default resignationModel;
