export interface Meeting {
  meeting_id: number;       // 会议申请ID
  employee_id: number;      // 员工ID
  meeting_time: string;     // 会议时间
  location: string;         // 会议地点
  topic: string;            // 会议主题
  duration: number;         // 会议时长
  approver_id: number;      // 审批人ID
  is_approved: number;      // 是否审批通过的状态码
}