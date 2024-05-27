import router from '@ohos.router'

class Task01 {
  static id: number = 1
  // 任务状态：是否完成
  finished: boolean = false
}

@Styles function card01() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}

// 任务完成样式
@Extend(Text) function finishedTask01() {
  .decoration({type:TextDecorationType.LineThrough})
  .fontColor('#B1B2B1')
}

@Entry
@Component
struct Todo {
  //总任务数量
  @State totalTask: number = 0
  //已完成任务数量
  @State finishTask: number = 0
  // 任务数组
  @State tasks: Task01[] = []
  //用户输入
  @State inputValue: Array<string> = []
  //控制输入框和文本
  @State isEditing : Array<boolean> = new Array(100).fill(true)
  //存储点击后的值
  @State displayedValue: Array<string> = []
  //截止日期
  @State Deadline:Array<Date> = new Array(100).fill(new Date('2024-5-1'))

  handleTaskChange() {
    // 1.更新任务总数量
    this.totalTask = this.tasks.length
    // 2.更新已完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.fanhui'))
          .width(30)
          .margin({ top: 10, right: 100 })
          .onClick(() => {
            //返回到首页
            router.back()
          })
        Text('待办事项')
          .fontSize(30)
          .margin({ top: 10, right: 100 })
      }.width('100%').backgroundColor('#fff').height(50)

      Row(){
        Text('待办事项进度:')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin({right:20})
        Stack(){
          Progress({
            value: this.finishTask,
            total: this.totalTask,
            type: ProgressType.Ring
          })
            .width(100)
          Row(){
            Text(this.finishTask.toString())
              .fontSize(24)
              .fontColor('#36D')
            Text(' / ' + this.totalTask.toString())
              .fontSize(24)
          }
        }
      }.card01()
      .margin({top:20,bottom:10})
      .justifyContent(FlexAlign.SpaceEvenly)

      //2.新增任务按钮
      Button('新增任务')
        .width(150)
        .margin({bottom: 10})
        .onClick(() => {
          // 1.新增任务数据
          this.tasks.push(new Task01())
          // 2.更新任务总数量
          this.handleTaskChange()
        })

      List() {
        ForEach(this.tasks, (item: Task01, index) => {
          ListItem() {
            Row() {
              if (this.isEditing[index]) {
                Column(){
                  Row() {
                    TextInput({ placeholder: '请输入任务', text: this.inputValue[index] })
                      .onChange((value: string) => {
                        this.inputValue[index] = value;
                      })
                      .width('60%')
                      .fontWeight(FontWeight.Bold)
                    Button('确定')
                      .onClick(() => {
                        this.displayedValue[index] = this.inputValue[index];
                        this.isEditing[index] = false; // 设置为非编辑状态
                      })
                      .margin({  left: 10 })
                      .width('20%')
                      .height(30)
                      .backgroundColor('#bec1d1')

                  }.margin({top:10})
                Button("选择日期").width(120).height(30).margin({top:10,right:80}).backgroundColor('#bec1d1').onClick(() => {
                  DatePickerDialog.show({
                    start: new Date("2024-5-1"),
                    end: new Date("2100-12-31"),
                    selected: this.Deadline[index],
                    onAccept: (value: DatePickerResult) => {
                      const selectedDate = new Date(value.year, value.month, value.day)
                      this.Deadline[index] = selectedDate
                      console.log('截止时间:', this.Deadline.toString());
                    },
                    onCancel: () => {
                      console.info("DatePickerDialog:onCancel()")
                    },
                  })
                })
                }

              } else {
                Column() {
                  Text(this.displayedValue[index])
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('80%')

                  Text('截止时间: '+`${this.Deadline[index].getFullYear()}-${(this.Deadline[index].getMonth() + 1).toString().padStart(2, '0')}-${this.Deadline[index].getDate().toString().padStart(2, '0')}`)
                    .margin({ top: 20 })
                    .fontSize(20)
                    .width('80%')
                }
              }
              Checkbox()
                .select(item.finished)
                .onChange(value => {
                  // 更新当前任务状态
                  item.finished = value
                  // 更新已完成任务数量
                  this.handleTaskChange()
                })
            }
            .card01()
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({top:10})
          }
          .swipeAction({ end: this.DeleteButton(index) })
        })
      }.width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }
    .width('100%').height('100%').backgroundColor('#F1F2F3')
  }

  @Builder DeleteButton(index: number){
    Button(){
      Image($r('app.media.shanchu'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin({top:20,left:5})
    .onClick(() => {
      this.tasks.splice(index, 1)
      this.inputValue.splice(index, 1)
      this.displayedValue.splice(index, 1)
      this.isEditing.splice(index, 1)
      this.Deadline.splice(index, 1)
      this.handleTaskChange()
    })
  }
}