import AttendanceInfo from '../viewmodel/AttendanceInfo'
import {AttendanceResponse} from '../viewmodel/AttendanceInfo'
import PreferencesUtil from '../util/preferencesUtil'
import http from '@ohos.net.http';
class AttendanceModel {
  baseURL = 'http://172.16.24.50:8080'

  async  GetAttendanceStats(attendanceInfo: AttendanceInfo): Promise<{ normal: number; late: number; earlyLeave: number }> {
    let employee_id = attendanceInfo.employee_id
    employee_id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    const year = attendanceInfo.sign_day.getFullYear()
    const month = attendanceInfo.sign_day.getMonth()+1
    return new Promise((resolve,reject)=>{
      let httpRequest = http.createHttp()
      httpRequest.request(
        `${this.baseURL}/attendanceStats/${employee_id}/${year}/${month}`,
        {
          method:http.RequestMethod.GET
        }
      ).then(resp=>{
        if(resp.responseCode === 200) {
          console.log('http --成功',resp.result);
          const result = JSON.parse(resp.result.toString()) as AttendanceResponse
          if(result.code === 1) {
            resolve(result.data)
          } else {
            console.log('请求成功但响应有误', result);
            reject('获取考勤记录失败');
          }
        } else {
          console.log('http --失败',resp.result)
          reject('获取考勤记录失败');
        }
      }).catch(error => {
        console.log('获取考勤记录失败',JSON.stringify(error))
        reject('获取考勤记录失败');
      })
    })
  }
}
const attendanceModel = new AttendanceModel()
export default attendanceModel