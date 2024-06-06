export default class ApprovalCenterResponse{
  code: number;
  msg: string;
  data: string;
}


// 报销管理
export interface ReimburseInfo {
  reimbursement_id: number;
  approver_id: number;
  is_approved: number;
}

export interface ReimburseResponse {
  code: number;
  msg: string;
  data: ReimburseData;
}

export interface ReimburseData {
  reimbursement_id: number;
  employee_id: number;
  amount: number;
  reason: string;
  claim_time: Date;
  approver_id: number;
  is_approved: number;
  name:string
}

// 调岗管理
export interface TransferInfo {
  transferId: number;
  approverId: number;
  isApproved: number;
}

export interface TransferResponse {
  code: number;
  msg: string;
  data: TransferData;
}

export interface TransferData {
  transferId: number;
  employeeId: number;
  transferToDepartment: string;
  transferToDepartmentId:number
  transferToPosition: string;
  approverId: number;
  isApproved: number;
  name:string
}

// 补卡管理
export interface RepairCardInfo {
  makeUpCardId: number;
  approverId: number;
  isApproved: number;
}

export interface RepairCardResponse {
  code: number;
  msg: string;
  data: RepairCardData;
}

export interface RepairCardData {
  makeUpCardId:number
  employeeId:number
  applicationDate:Date
  remark:string
  approverId:number
  isApproved:number
  name:string
}
// 请假管理
export interface LeaveInfo {
  leaveId: number;
  employeeId: number;
  startTime: Date;
  endTime: Date;
  departureLocation: string;
  destination: string;
  purposeOrReason: string;
  vehicle: string;
  duration: number;
  approverId: number;
  isApproved: number;
}

export interface LeaveResponse {
  code: number;
  msg: string;
  data: LeaveData;
}

export interface LeaveData {
  leave_id: number;
  employee_id: number;
  start_time: Date;
  end_time: Date;
  departure_location: string;
  destination: string;
  purpose_or_reason: string;
  vehicle: string;
  duration: number;
  approver_id: number;
  is_approved: number;
  name:string
}

// 加班管理
export interface OverTimeInfo {
  overtimeId: number;
  employeeId: number;
  startTime: Date;
  endTime: Date;
  reason: string;
  duration: number;
  approverId: number;
  isApproved: number;
}

export interface OverTimeResponse {
  code: number;
  msg: string;
  data: OverTimeData;
}

export interface OverTimeData {
  overtime_id: number;
  employee_id: number;
  start_time: Date;
  end_time: Date;
  reason: string;
  duration: number;
  approver_id: number;
  is_approved: number;
  name:string
}

// 成为正式成员管理
export interface BecomeFullMemberInfo {
  becomeFullMemberId: number;
  employeeId: number;
  approverId: number;
  position: string;
  isApproved: number;
  effectiveDate: Date;
}

export interface BecomeFullMemberResponse {
  code: number;
  msg: string;
  data: BecomeFullMemberData;
}

export interface BecomeFullMemberData {
  become_full_member_id: number;
  employee_id: number;
  approver_id: number;
  position: string;
  is_approved: number;
  effective_date: Date;
  name:string
}
export interface ResignationInfo {
  resignationId: number;
  employeeId: number;
  reason: string;
  approverId: number;
  isApproved: number;
}

export interface ResignationResponse {
  code: number;
  msg: string;
  data: ResignationData;
}

export interface ResignationData {
  resignationId: number;
  employeeId: number;
  reason: string;
  approverId: number;
  isApproved: number;
  name:string
}
// 请假管理
export interface TakeOffInfo {
  take_off_id: number;
  employeeId: number;
  leave_type:number;
  start_time: Date;
  end_time: Date;
  reason: string;
  approverId: number;
  isApproved: number;
}

export interface TakeOffResponse {
  code: number;
  msg: string;
  data: TransferData;
}

export interface TakeOffData {
  take_off_id: number;
  employeeId: number;
  leave_type:number;
  start_date: Date;
  end_date:Date;
  start_time: Date;
  end_time: Date;
  reason: string;
  approved_id: number;
  is_approved: number;
  name: string;
}