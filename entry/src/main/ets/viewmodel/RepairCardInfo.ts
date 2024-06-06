export default class RepairCardInfo{
  make_up_card_id:number
  employee_id:number
  application_date:Date
  remark:string //备注
  approver_id:number
  is_approved:number
  name:string
}
export interface  RepairCardResponse{
  code:number
  msg:string
  data:string
}