import http from '@ohos.net.http';
import RepairCardInfo from '../viewmodel/RepairCardInfo';
import PreferencesUtil from '../util/preferencesUtil'
class RepairCardModel {
  baseURL: string = 'http://172.16.24.50:8080';



  async RepairCardForView(employeeId: number) {
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      const httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/RepairCardForView/${id}`,
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
          reject('获取补卡申请失败');
        }
      }).catch(error => {
        console.log('获取补卡申请失败：', JSON.stringify(error));
        reject('获取补卡申请失败');
      });
    });
  }


  async RepairCardApply(repairCardInfo:RepairCardInfo) {
    let employeeId = repairCardInfo.employee_id
    employeeId = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const year = repairCardInfo.application_date.getFullYear();
    const month = (repairCardInfo.application_date.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = repairCardInfo.application_date.getDate().toString().padStart(2, '0');
    const hours = repairCardInfo.application_date.getHours().toString().padStart(2, '0');
    const minutes = repairCardInfo.application_date.getMinutes().toString().padStart(2, '0');
    const requestBody = {
      employeeId:employeeId,
      remark:repairCardInfo.remark,
      applicationDate:`${year}-${month}-${day} ${hours}:${minutes}:00`
    };
    console.log('发送的请求体：',JSON.stringify(requestBody).toString());
    return new Promise((resolve,reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/RepairCardApply`,
        {
          method:http.RequestMethod.POST,
          extraData:JSON.stringify(requestBody).toString()
        }
      ).then(resp => {
        if(resp.responseCode === 200) {
          console.log('http--成功',resp.result);
          const result = JSON.stringify(resp.result.toString());
          resolve(result);
        } else {
          console.log('http--失败',resp.result);
          reject('申请失败');
        }
      }).catch(error => {
        console.log('补卡申请失败：',JSON.stringify(error));
        reject('补卡申请失败');
      });
    });
  }

  // 查看未审批的补卡申请
  async GetNoReviewRepairCards() {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noRepairCard`,
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
          reject('获取未审批的补卡申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的补卡申请失败：', JSON.stringify(error));
        reject('获取未审批的补卡申请失败');
      });
    });
  }

  // 审批补卡申请
  async ReviewRepairCard(makeUpCardId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      console.log(makeUpCardId.toString())
      httpRequest.request(
        `${this.baseURL}/RepairCardForReview/${makeUpCardId}/${approverId}/${isApproved}`,
        {
          method: http.RequestMethod.PUT
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString());
          resolve(result);
        } else {
          console.log('http--失败', resp.result);
          reject('审批失败');
        }
      }).catch(error => {
        console.log('审批补卡申请失败：', JSON.stringify(error));
        reject('审批补卡申请失败');
      });
    });
  }




}

const repairCardModel = new RepairCardModel();
export default repairCardModel;
