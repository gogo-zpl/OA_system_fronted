import http from '@ohos.net.http';
import {TransferInfo,TransferResponse,TransferData} from '../viewmodel/ApprovalCenterInfo';
import PreferencesUtil from '../util/preferencesUtil'
class TransferModel {
  baseURL: string = 'http://172.16.24.50:8080';

   async getTransferById(employeeId: number) {
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/applyForView/${id}`,
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
          reject('获取调岗申请失败');
        }
      }).catch(error => {
        console.log('获取调岗申请失败：', JSON.stringify(error));
        reject('获取调岗申请失败');
      });
    });
  }

  // 查看未审批的调岗申请
  async GetNoReviewTransfers(){
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewTransfer`,
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
          reject('获取未审批的调岗申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的调岗申请失败：', JSON.stringify(error));
        reject('获取未审批的调岗申请失败');
      });
    });
  }

  // 审批调岗申请
  async ReviewTransfer(transferId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/transferReview/${transferId}/${approverId}/${isApproved}`,
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
        console.log('审批调岗申请失败：', JSON.stringify(error));
        reject('审批调岗申请失败');
      });
    });
  }
}



const transferModel = new TransferModel();
export default transferModel;
