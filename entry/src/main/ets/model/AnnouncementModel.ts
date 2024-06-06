import http from '@ohos.net.http'
import AnnouncementInfo,{AnnouncementResponse,AnnouncementData,UpAnnouncementResponse} from '../viewmodel/AnnouncementInfo'
import PreferencesUtil from '../util/preferencesUtil'
class AnnouncementModel{
  //baseURL:string = 'http://172.16.24.10:8080'
  baseURL:string = 'http://172.16.24.50:8080'
  async UpAddAnnouncement(announcementInfo: AnnouncementInfo) {
    let id = announcementInfo.initiator_id
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const requestBody = {
      initiator_id: id,
      content: announcementInfo.content,
      title: announcementInfo.title
    };
    console.log('发送的请求体：', JSON.stringify(requestBody).toString());

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/addAnno`,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString()) as UpAnnouncementResponse;
          resolve(result);
        } else {
          console.log('http--失败1', resp.result);
          reject('发布公告失败');
        }
      }).catch(error => {
        console.log('发布公告失败error(catch):', JSON.stringify(error));
        reject('发布公告失败');
      });
    });
  }
  GetAnnouncements() {

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/annoList`,
        {
          method: http.RequestMethod.GET,
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          if (result.code === 1) {
            resolve(result.data);
          } else {
            console.log('请求成功但响应有误', result);
            reject('获取公告列表失败');
          }
        } else {
          console.log('http--失败1', resp.result);
          reject('获取公告列表失败');
        }
      }).catch(error => {
        console.log('获取公告失败error(catch):', JSON.stringify(error));
        reject('获取公告失败');
      });
    });
  }


}
const announcementModel = new AnnouncementModel()
export default announcementModel