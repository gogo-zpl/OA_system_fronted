export default class AnnouncementInfo{
  initiator_id:number
  content:string
  title:string
}
export interface AnnouncementResponse{
  code:number
  msg:string
  data:AnnouncementData
}
export interface AnnouncementData{
  announcement_id:number
  initiator_id:number
  content:string
  publish_time: Date
  approver_id: number
  status: number
  title: string
}
export interface UpAnnouncementResponse{
  code: number;
  msg: string;
  data: string;
}