/*import router from '@ohos.router'
import TakeOffModel from '../model/TakeOffModel'
import { TakeOffData } from '../viewmodel/ApprovalCenterInfo'
import OverTimeModel from '../model/OverTimeModel'
import MeetingModel from '../model/MeetingModel'
import LeaveModel from '../model/LeaveModel'
import BecomeFullMemberModel from '../model/BecomeFullMemberModel'
import ReimburseModel from '../model/ReimburseModel'
import TransferModel from '../model/TransferModel'
import ResignationModel from '../model/ResignationModel';
import RepairCardModel from '../model/RepairCardModel'
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
  leaveType: string = ''  // 将 leaveType 的类型改为 string
  startDate: Date = new Date()
  endDate: Date = new Date()
  startTime: Date = new Date()
  endTime: Date = new Date()
  take_off_id: number = 0
  reason: string = ''
}

@Styles function cardStyle() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

@Entry
@Component
struct ApprovalCenter {
  @State requests: TakeOffRequest[] = []

  aboutToAppear() {
    this.loadTakeOffRequests()
  }

  loadTakeOffRequests() {
    TakeOffModel.getTakeOffById(1)  // 这里1是一个示例ID，请根据实际情况替换
      .then((data: TakeOffData[]) => {
        this.requests = data.filter(item => item.is_approved === 1).map(item => ({
          ...new TakeOffRequest(),
          name: item.name,
          leaveType: item.leave_type.toString(),  // 转换 leaveType 的类型为 string
          startDate: new Date(item.start_time),
          endDate: new Date(item.end_time),
          startTime: new Date(item.start_time),
          endTime: new Date(item.end_time),
          take_off_id: item.take_off_id,
          approved: item.is_approved === 1,
          reason: item.reason
        }))
      })
      .catch(error => {
        console.error('获取请假申请出错:', error)
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
        Text('已通过申请')
          .fontSize(20)
          .fontWeight(700)
          .margin({ left: 16 })
      }.width('100%').height(60).alignItems(VerticalAlign.Center)

      List() {
        ForEach(this.requests, (item: TakeOffRequest, index) => {
          ListItem() {
            Row() {
              Column() {
                Text(`请假原因: ${item.reason}`)
                  .margin({ top: 20 })
                  .fontSize(20)
                  .width('90%')
                Text(`请假类型: ${item.leaveType}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
                Text(`开始日期: ${item.startDate.toLocaleDateString()}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
                Text(`结束日期: ${item.endDate.toLocaleDateString()}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
                Text(`开始时间: ${item.startTime.toLocaleTimeString()}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
                Text(`结束时间: ${item.endTime.toLocaleTimeString()}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
                Text(`申请人: ${item.name}`)
                  .margin({ top: 10 })
                  .fontSize(20)
                  .width('90%')
              }.width('100%')
            }
            .cardStyle()
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 10 })
          }
        })
      }.width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }.width('100%').height('100%').backgroundColor('#F1F2F3')
  }
}*/
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
  isApproved: boolean = false
  name: string = ''
  transferToPosition: string = ''
  transferToDepartmentId: number = 0
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
  employee_id: number = 0
  employee_name: string = ''
  remark: string = ''
  application_date: Date = new Date()
  make_up_card_id: number = 0
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
  @State requests0: Request[] = []
  @State requests1: Request[] = []
  @State requests2: Request[] = []
  @State requests3: Request[] = []
  @State requests4: Request[] = []
  @State requests5: Request[] = []
  @State requests6: Request[] = []
  @State requests7: Request[] = []
  @State requests8: Request[] = []
  @State requests9: Request[] = []
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

  loadTakeOffRequests() {
    TakeOffModel.getTakeOffById(1)
      .then((data: TakeOffData[]) => {
        this.requests0 = data.map(item => ({
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
    LeaveModel.getLeaveById(1)
      .then((data: LeaveData[]) => {
        this.requests1 = data.map(item => ({
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
    MeetingModel.getMeetingById(1)
      .then((data: MeetingData[]) => {
        this.requests2 = data.map(item => ({
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
    OverTimeModel.getOvertimeById(1)
      .then((data: OverTimeData[]) => {
        this.requests3 = data.map(item => ({
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
    ReimburseModel.getReimbursementById(1)
      .then((data: ReimburseData[]) => {
        this.requests4 = data.map(item => ({
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
    BecomeFullMemberModel.fullMemberView(1)
      .then((data: BecomeFullMemberData[]) => {
        this.requests5 = data.map(item => ({
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
    TransferModel.getTransferById(1)
      .then((data: TransferData[]) => {
        this.requests6 = data.map(item => ({
          ...new TransferRequest(),
          name: item.name,
          transferToDepartment: item.transferToDepartment,
          transferToDepartment_id: item.transferToDepartmentId,
          transferToPosition:item.transferToPosition,
          approved: item.isApproved === 1
        }))
        this.handleRequestChange()
      })
      .catch(error => {
        console.error('获取调岗申请出错:', error)
      })
  }

  loadResignationRequests() {
    ResignationModel.getResignationById(1)
      .then((data: ResignationData[]) => {
        this.requests7 = data.map(item => ({
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
    RepairCardModel.RepairCardForView(1)
      .then((data: RepairCardData[]) => {
        this.requests8 = data.map(item => ({
          ...new RepairCardRequest(),
          name: item.name,
          employee_id: item.employeeId,
          remark: item.remark,
          approver_id:item.approverId,
          application_date: new Date(item.applicationDate),
          make_up_card_id: item.makeUpCardId,
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
        Text('已通过申请')
          .fontSize(20)
          .fontWeight(700)
          .margin({ left: 16 })
      }.width('100%').height(60).alignItems(VerticalAlign.Center)
      List() {
        ForEach(this.requests2, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('meeting_id' in item) {
                  Text('会议申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
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
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests0, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('take_off_id' in item) {
                  Text('请假申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
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
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests1, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                 if ('leaveId' in item) {
                   Text('出差申请')
                     .margin({ top:10,right:50 })
                     .fontSize(22)
                     .width('90%')
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
                Text(`申请人: ${item.name}`)
                  .margin({ top: 20 })
                  .fontSize(20)
                  .width('90%')
                 }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests3, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('overtimeId' in item) {
                  Text('加班申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
                  Text(`加班原因: ${item.reason}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`加班时长: ${item.duration}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests5, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('becomeFullMemberId' in item) {
                  Text('转正申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
                  Text(`申请职位: ${item.position}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`生效日期: ${item.effectiveDate.toLocaleDateString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests4, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('reimbursementId' in item) {
                  Text('报销申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
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
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests6, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('transferId' in item) {
                  Text('调岗申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
                  Text(`目标部门: ${item.transferToDepartment}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`目标职位: ${item.transferToPosition}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests7, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('resignationId' in item) {
                  Text('离职申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
                  Text(`离职原因: ${item.reason}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%');
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })

        ForEach(this.requests8, (item: Request, index) => {
          ListItem() {
            Row() {
              Column() {
                if ('make_up_card_id' in item) {
                  Text('补卡申请')
                    .margin({ top:10,right:50 })
                    .fontSize(22)
                    .width('90%')
                  Text(`补卡原因: ${item.remark}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                  Text(`补卡时间: ${item.application_date.toLocaleString()}`)
                    .margin({ top: 10 })
                    .fontSize(20)
                    .width('90%')
                  Text(`申请人: ${item.name}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('90%')
                }
              }
              .cardStyle()
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({ top: 10 })
            }
          }
        })
      }.width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)

    }.width('100%').height('100%').backgroundColor('#F1F2F3')
  }

}