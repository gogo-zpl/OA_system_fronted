import http from '@ohos.net.http';
import ApprovalCenterResponse,{ MeetingInfo, MeetingResponse, MeetingData} from '../viewmodel/MeetingInfo';
import PreferencesUtil from '../util/preferencesUtil'
class MeetingModel {
  baseURL: string = 'http://172.16.24.50:8080';

  // 根据用户id查看自己的会议申请
  async getMeetingById(employeeId: number){
    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/getById/${id}`,
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
          reject('获取个人会议申请失败');
        }
      }).catch(error => {
        console.log('获取个人会议申请失败：', JSON.stringify(error));
        reject('获取个人会议申请失败');
      });
    });
  }

  // 查看未审批的会议申请
  async getNoReviewMeeting() {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/noReviewMeeting`,
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
          reject('获取未审批的会议申请失败');
        }
      }).catch(error => {
        console.log('获取未审批的会议申请失败：', JSON.stringify(error));
        reject('获取未审批的会议申请失败');
      });
    });
  }

  // 审批会议申请
  async meetingReview(meetingId: number, approverId: number, isApproved: number) {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/meetingReview/${meetingId}/${approverId}/${isApproved}`,
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
        console.log('审批会议申请失败：', JSON.stringify(error));
        reject('审批会议申请失败');
      });
    });
  }
}

const meetingModel = new MeetingModel();
export default meetingModel;
