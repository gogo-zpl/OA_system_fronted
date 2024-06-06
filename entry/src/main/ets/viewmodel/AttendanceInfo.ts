export default class  AttendanceInfo{
  attendance_id:number              //签到id
  employee_id:number                //员工id
  sign_in_status:number             //签到状态为0，表示未签到，为1表示正常签到
  sign_in_time:Date                 //签到时间 yyyy-MM-dd HH:mm:ss
  sign_out_time:Date                //签退时间 yyyy-MM-dd HH:mm:ss
  sign_out_status:number            // 签退状态：0表示未签退，1表示正常签退
  sign_day:Date                     //签到日期

}

export  interface AttendanceResponse {
  code: number;
  msg: string;
  data: {
    normal: number;
    late: number;
    earlyLeave: number;
  }
}
