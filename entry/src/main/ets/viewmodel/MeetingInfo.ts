export default class ApprovalCenterResponse{
  code: number;
  msg: string;
  data: string;
}

//会议管理
export interface MeetingInfo{
  meeting_id:number
  approver_id:number
  is_approved:number
}
export interface MeetingResponse{
  code:number
  msg:string
  data:MeetingData
}
export interface MeetingData{
  meeting_id:number
  employee_id:number
  meeting_time:Date
  location: string
  topic: string
  duration:number
  approver_id: number
  is_approved: number
  name:string
}
