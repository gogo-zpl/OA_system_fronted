import router from '@ohos.router'
import TakeOffModel from '../model/TakeOffModel'
import OverTimeModel from '../model/OverTimeModel'
import MeetingModel from '../model/MeetingModel'
import LeaveModel from '../model/LeaveModel'
import BecomeFullMemberModel from '../model/BecomeFullMemberModel'
import ReimburseModel from '../model/ReimburseModel'
import TransferModel from '../model/TransferModel'
import ResignationModel from '../model/ResignationModel';
import RepairCardModel from '../model/RepairCardModel'
import TakeOffResponse,{ TakeOffInfo, TakeOffData } from '../viewmodel/ApprovalCenterInfo'
import ApprovalResponse,{ MeetingInfo, MeetingData } from '../viewmodel/MeetingInfo'
import LeaveResponse,{ LeaveInfo, LeaveData } from '../viewmodel/ApprovalCenterInfo'
import OverTimeResponse, { OverTimeInfo, OverTimeData } from '../viewmodel/ApprovalCenterInfo'
import ReimburseResponse, { ReimburseInfo, ReimburseData } from '../viewmodel/ApprovalCenterInfo'
import BecomeFullMemberResponse, { BecomeFullMemberInfo, BecomeFullMemberData } from '../viewmodel/ApprovalCenterInfo'
import TransferResponse, { TransferInfo, TransferData } from '../viewmodel/ApprovalCenterInfo'
import ResignationResponse, { ResignationInfo, ResignationData } from '../viewmodel/ApprovalCenterInfo';
import RepairCardResponse, { RepairCardInfo, RepairCardData } from '../viewmodel/ApprovalCenterInfo'


class TakeOffRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  leaveType: number = 0
  startTime: Date = new Date()
  endTime: Date = new Date()
  take_off_id: number = 0
  reason: string = ''
}

class LeaveRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  startTime: Date = new Date()
  endTime: Date = new Date()
  departureLocation: string = ''
  destination: string = ''
  purposeOrReason: string = ''
  vehicle: string = ''
  duration: number = 0
  leaveId: number = 0
}

class OverTimeRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  startTime: Date = new Date()
  endTime: Date = new Date()
  reason: string = ''
  duration: number = 0
  overtimeId: number = 0
}

class MeetingRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  location: string = ''
  requestDate: Date = new Date()
  meeting_id: number = 0
  topic:string=''
}

class ReimburseRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  amount: number = 0
  reason: string = ''
  claimTime: Date = new Date()
  reimbursementId: number = 0
}

class BecomeFullMemberRequest { // 转正申请的请求类
  static id: number = 1
  approved: boolean = false
  name: string = ''
  position: string = ''
  effectiveDate: Date = new Date()
  becomeFullMemberId: number = 0
}

class TransferRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  transferToPosition: string = ''
  transferToDepartment_id: number = 0
  transferToDepartment: string = ''
  transferId: number = 0
}

class ResignationRequest {
  static id: number = 1;
  approved: boolean = false;
  name: string = '';
  reason: string = '';
  resignationId: number = 0;
}

class RepairCardRequest {
  static id: number = 1
  approved: boolean = false
  name: string = ''
  employeeId: number = 0
  employee_name: string = ''
  remark: string = ''
  applicationDate: Date = new Date()
  makeUpCardId: number = 0
}

@Styles function cardStyle() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

type Request = TakeOffRequest| LeaveRequest| MeetingRequest  | OverTimeRequest| ReimburseRequest |TransferRequest| BecomeFullMemberRequest| ResignationRequest| RepairCardRequest;

@Entry
@Component
struct ApprovalCenter {
  @State applistate: number = 0
  @State selecttype: number = 0
  @State requests: Request[] = []
  handleRequestChange() {
    // 更新总请求数和已审批请求数
  }

  aboutToAppear() {
    this.loadMeetingRequests()
    this.loadTakeOffRequests()
    this.loadLeaveRequests()
    this.loadOverTimeRequests()
    this.loadReimburseRequests()
    this.loadTransferRequests()
    this.loadBecomeFullMemberRequests()
    this.loadRepairCardRequests()
    this.loadResignationRequests()
  }

  loadRequests() {
    this.requests = [];

    switch (this.selecttype) {
      case 0:
        this.loadTakeOffRequests();
        break;

      case 1:
        this.loadLeaveRequests();
        break;

      case 2:
        this.loadMeetingRequests();
        break;

      case 3:
        this.loadOverTimeRequests();
        break;

      case 4:
        this.loadReimburseRequests();
        break;

      case 5:
        this.loadTransferRequests()
        break;

      case 6:
        this.loadBecomeFullMemberRequests();
        break;

      case 7:
        this.loadResignationRequests();
        break;

      case 8:
        this.loadRepairCardRequests();
        break;

    // 添加更多类型的加载逻辑
      default:
        this.requests = [];
    }
  }

  loadTakeOffRequests() {
    TakeOffModel.getNoReviewTakeOff()
      .then((data: TakeOffData[]) => {
        this.requests = data.map(item => ({
          ...new TakeOffRequest(),
          name: item.name,
          leaveType: item.leave_type,
          startTime: new Date(item.start_time),
          endTime: new Date(item.end_time),
          take_off_id: item.take_off_id,
          approved: item.is_approved === 1,
          reason: item.reason
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取请假申请出错:', error)
      })
  }

  loadLeaveRequests() {
    LeaveModel.getNoReviewLeave()
      .then((data: LeaveData[]) => {
        this.requests = data.map(item => ({
          ...new LeaveRequest(),
          name: item.name,
          startTime: new Date(item.start_time),
          endTime: new Date(item.end_time),
          departureLocation: item.departure_location,
          destination: item.destination,
          purposeOrReason: item.purpose_or_reason,
          vehicle: item.vehicle,
          duration: item.duration,
          leaveId: item.leave_id,
          approved: item.is_approved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取出差申请出错:', error)
      })
  }

  loadMeetingRequests() {
    MeetingModel.getNoReviewMeeting()
      .then((data: MeetingData[]) => {
        this.requests = data.map(item => ({
          ...new MeetingRequest(),
          applicantName: item.name,
          location: item.location,
          requestDate: new Date(item.meeting_time),
          meeting_id: item.meeting_id,
          approved: item.is_approved === 1,
          topic: item.topic,
          name:item.name
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取会议申请出错:', error)
      })
  }

  loadOverTimeRequests() {
    OverTimeModel.getNoReviewOvertime()
      .then((data: OverTimeData[]) => {
        this.requests = data.map(item => ({
          ...new OverTimeRequest(),
          name: item.name,
          startTime: new Date(item.start_time),
          endTime: new Date(item.end_time),
          reason: item.reason,
          duration: item.duration,
          overtimeId: item.overtime_id,
          approved: item.is_approved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取加班申请出错:', error)
      })
  }

  loadReimburseRequests() {
    ReimburseModel.getNoReviewReimbursement()
      .then((data: ReimburseData[]) => {
        this.requests = data.map(item => ({
          ...new ReimburseRequest(),
          name: item.name,
          amount: item.amount,
          reason: item.reason,
          claimTime: new Date(item.claim_time),
          reimbursementId: item.reimbursement_id,
          approved: item.is_approved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取报销申请出错:', error)
      })
  }

  loadBecomeFullMemberRequests() {
    BecomeFullMemberModel.getNoFullMemberView()
      .then((data: BecomeFullMemberData[]) => {
        this.requests = data.map(item => ({
          ...new BecomeFullMemberRequest(),
          name: item.name,
          position: item.position,
          effectiveDate: new Date(item.effective_date),
          becomeFullMemberId: item.become_full_member_id,
          approved: item.is_approved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取转正申请出错:', error)
      })
  }

  loadTransferRequests() {
    TransferModel.GetNoReviewTransfers()
      .then((data: TransferData[]) => {
        this.requests = data.map(item => ({
          ...new TransferRequest(),
          name: item.name,
          transferToDepartment: item.transferToDepartment,
          transferToDepartmentId: item.transferToDepartmentId,
          transferToPosition:item.transferToPosition,
          transferId:item.transferId,
          approved: item.isApproved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取调岗申请出错:', error)
      })
  }

  loadResignationRequests() {
    ResignationModel.getNoReviewResignations()
      .then((data: ResignationData[]) => {
        this.requests = data.map(item => ({
          ...new ResignationRequest(),
          name: item.name,
          reason: item.reason,
          resignationId: item.resignationId,
          approved: item.isApproved === 1
        }));
        this.handleRequestChange();
      })
      .catch(error => {
        console.error('获取离职申请出错:', error);
      });
  }

  loadRepairCardRequests() {
    RepairCardModel.GetNoReviewRepairCards()
      .then((data: RepairCardData[]) => {
        this.requests = data.map(item => ({
          ...new RepairCardRequest(),
          name: item.name,
          employeeId: item.employeeId,
          remark: item.remark,
          approverId:item.approverId,
          applicationDate: new Date(item.applicationDate),
          makeUpCardId: item.makeUpCardId,
          approved: item.isApproved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('Failed to fetch repair card requests:', error)
      })
  }



  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_public_arrow_left_filled'))
          .height(32)
          .onClick(() => {
            router.back()
          })
        Text('审批中心')
          .fontSize(20)
          .fontWeight(700)
          .margin({ left: 16 })
      }.width('100%').height(60).alignItems(VerticalAlign.Center)

      Row() {
        Select([
          { value: '请假申请', icon: "/common/public_icon.svg" },
          { value: '出差申请', icon: "/common/public_icon.svg" },
          { value: '会议申请', icon: "/common/public_icon.svg" },
          { value: '加班申请', icon: "/common/public_icon.svg" },
          { value: '报销申请', icon: "/common/public_icon.svg" },
          { value: '调岗申请', icon: "/common/public_icon.svg" },
          { value: '转正申请', icon: "/common/public_icon.svg" },
          { value: '离职申请', icon: "/common/public_icon.svg" },
          { value: '补卡申请', icon: "/common/public_icon.svg" }
        ])
          .value('选择类型')
          .font({ size: 16, weight: 500 })
          .fontColor('#182431')
          .selectedOptionFont({ size: 16, weight: 400 })
          .optionFont({ size: 16, weight: 400 })
          .onSelect((index: number) => {
            this.selecttype = index
            console.info(this.selecttype.toString())
            this.loadRequests();
            // 根据selecttype加载相应类型的申请
          })
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      List() {
        ForEach(this.requests, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('meeting_id' in item) {
                  Text(`会议主题: ${item.topic}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`地点: ${item.location}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`时间: ${item.requestDate}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                } else if ('take_off_id' in item) {
                  Text(`请假原因: ${item.reason}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`请假类型: ${item.leaveType}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`开始时间: ${item.startTime.toLocaleString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`结束时间: ${item.endTime.toLocaleString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                }else if ('leaveId' in item) {
                  Text(`出发地点: ${item.departureLocation}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`目的地: ${item.destination}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`出差事由: ${item.purposeOrReason}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`交通工具: ${item.vehicle}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`出差时长: ${item.duration}天`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                }else if ('overtimeId' in item) {
                  Text(`加班原因: ${item.reason}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`加班时长: ${item.duration}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                }else if ('becomeFullMemberId' in item) {
                  Text(`申请职位: ${item.position}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`生效日期: ${item.effectiveDate.toLocaleDateString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                }else if ('reimbursementId' in item) {
                  Text(`报销金额: ${item.amount}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`报销原因: ${item.reason}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`申请时间: ${item.claimTime.toLocaleString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                } else if ('transferId' in item) {
                  Text(`目标部门: ${item.transferToDepartment}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`目标职位: ${item.transferToPosition}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }else if ('resignationId' in item) {
                  Text(`离职原因: ${item.reason}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%');
                }else if ('makeUpCardId' in item) {
                  Text(`补卡原因: ${item.remark}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`补卡时间: ${item.applicationDate.toLocaleString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                }
                Text(`申请人: ${item.name}`)
                  .margin({ top: 20 })
                  .fontSize(20)
                  .width('90%')
              }

              Checkbox()
                .select(item.approved)
                .onChange(value => {
                  item.approved = value
                  this.handleRequestChange()
                  // 调用接口更新审批状态
                  if ('meeting_id' in item) {
                    MeetingModel.meetingReview(item.meeting_id, 0, value ? 1 : 0)
                      .then((response: ApprovalResponse) => {
                        if (response.code === 1) {
                          console.log('会议申请状态更新成功')
                        } else {
                          console.error('会议申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('会议申请状态更新请求出错:', error)
                      })
                  } else if ('take_off_id' in item) {
                    TakeOffModel.takeOffReview(item.take_off_id, 0, value ? 1 : 0)
                      .then((response: TakeOffResponse) => {
                        if (response.code === 1) {
                          console.log('请假申请状态更新成功')
                        } else {
                          console.error('请假申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('请假申请状态更新请求出错:', error)
                      })
                  }else if ('leaveId' in item) {
                    LeaveModel.leaveReview(item.leaveId, 0, value ? 1 : 0)
                      .then((response: LeaveResponse) => {
                        if (response.code === 1) {
                          console.log('出差申请状态更新成功')
                        } else {
                          console.error('出差申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('出差申请状态更新请求出错:', error)
                      })
                  }else if ('overtimeId' in item) {
                    OverTimeModel.overtimeReview(item.overtimeId, 0, value ? 1 : 0)
                      .then((response: OverTimeResponse) => {
                        if (response.code === 1) {
                          console.log('加班申请状态更新成功')
                        } else {
                          console.error('加班申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('加班申请状态更新请求出错:', error)
                      })
                  }else if ('becomeFullMemberId' in item) { // 更新转正申请的状态
                    BecomeFullMemberModel.fullMemberReview(item.becomeFullMemberId, 0, value ? 1 : 0)
                      .then((response: BecomeFullMemberResponse) => {
                        if (response.code === 1) {
                          console.log('转正申请状态更新成功')
                        } else {
                          console.error('转正申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('转正申请状态更新请求出错:', error)
                      })
                  }else if ('reimbursementId' in item) {
                    ReimburseModel.reimbursementReview(item.reimbursementId, 0, value ? 1 : 0)
                      .then((response: ReimburseResponse) => {
                        if (response.code === 1) {
                          console.log('报销申请状态更新成功')
                        } else {
                          console.error('报销申请状态更新失败:', response.msg)
                        }
                      })
                      .catch(error => {
                        console.error('报销申请状态更新请求出错:', error)
                      })
                  }else if ('transferId' in item) {
                    TransferModel.ReviewTransfer(item.transferId, 0, value ? 1 : 0)
                      .then((response: TransferResponse) => {
                        if (response.code === 1) {
                          console.log('调岗申请状态更新成功');
                        } else {
                          console.error('调岗申请状态更新失败:', response.msg);
                        }
                      })
                      .catch((error) => {
                        console.error('调岗申请状态更新请求出错:', error);
                      });
                  }else if ('resignationId' in item) {
                    ResignationModel.reviewResignation(item.resignationId, 0, value ? 1 : 0)
                      .then((response: ResignationResponse) => {
                        if (response.code === 1) {
                          console.log('离职申请状态更新成功');
                        } else {
                          console.error('离职申请状态更新失败:', response.msg);
                        }
                      })
                      .catch(error => {
                        console.error('离职申请状态更新请求出错:', error);
                      });
                  }else if ('makeUpCardId' in item) {
                    RepairCardModel.ReviewRepairCard(item.makeUpCardId, 0, value ? 1 : 0)
                      .then((response: RepairCardResponse) => {
                        if (response.code === 1) {
                          console.log('补卡申请状态更新成功');
                        } else {
                          console.error('补卡申请状态更新失败:', response.msg);
                        }
                      })
                      .catch(error => {
                        console.error('补卡申请状态更新请求出错:', error);
                      });
                  }
                })
            }
            .cardStyle()
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 10 })
          }
          .swipeAction({ end: this.deleteButton(index) })
        })
      }.width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }.width('100%').height('100%').backgroundColor('#F1F2F3')
  }

  @Builder deleteButton(index: number) {
    Button() {
      Image($r('app.media.shanchu'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin({ top: 20, left: 5 })
    .onClick(() => {
      this.requests.splice(index, 1)
      this.handleRequestChange()
    })
  }
}