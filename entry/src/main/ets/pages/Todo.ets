import router from '@ohos.router'
import TodoModel from '../model/TodoModel'
import TodoInfo, { TodoShow, TodoData,TodoUpdate } from '../viewmodel/TodoInfo'
import PreferencesUtil from '../util/preferencesUtil'
import Title from '../components/title/Title'

class Task01 {
  static id: number = 1
  finished: boolean = false
  content: string = ''
  due_date: Date = new Date()
  todo_id:number =0
}

@Styles function card01() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

@Extend(Text) function finishedTask01() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B2B1')
}
async function getEmployeeId(): Promise<number> {
  try {
    const id = await PreferencesUtil.getPreferenceValue('User', 'employee_id', 0);
    return id as number; // 使用类型断言将结果转换为 number 类型
  } catch (error) {
    console.error('Error fetching employee ID:', error);
    return 0; // 返回默认值或者适当的错误处理
  }
}
@Entry
@Component
struct Todo {
  @State totalTask: number = 0
  @State finishTask: number = 0
  @State tasks: Task01[] = []
  @State inputValue: Array<string> = []
  @State isEditing: Array<boolean> = []
  @State displayedValue: Array<string> = []
  @State todoInfo: Array<TodoInfo> = []
  @State todoData: TodoData | null = null

  handleTaskChange() {
    this.totalTask = this.tasks.length
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  aboutToAppear() {
    this.TodoList()
  }

  TodoList() {
    TodoModel.ShowTodoRequest()
      .then((todos: TodoData[]) => {
        this.tasks = todos.map(todo => ({
          ...new Task01(),
          content: todo.content,
          todo_id: todo.todo_id,
          finished: todo.is_completed === 1,
          due_date: new Date(todo.due_date)
        }))
        this.todoInfo = todos.map(todo => ({
          employee_id: todo.employee_id,
          content: todo.content,
          due_date: new Date(todo.due_date)
        }))
        this.inputValue = todos.map(todo => todo.content)
        this.displayedValue = todos.map(todo => todo.content)
        this.isEditing = todos.map(() => false)
        this.handleTaskChange()
      })
      .catch(error => {
        console.error('获取代办事项出错:', error)
      })
  }

  addTask() {
    const newTask = new Task01()
    this.tasks.push(newTask)
    this.inputValue.push('')
    this.displayedValue.push('')
    this.isEditing.push(true)
    this.todoInfo.push({ employee_id: 0, content: '', due_date: new Date() })
    this.handleTaskChange()
  }

  build() {
    Column() {
      Title({ pageTitle: '待办事项' })

      Row() {
        Text('待办事项进度:')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 20 })
        Stack() {
          Progress({
            value: this.finishTask,
            total: this.totalTask,
            type: ProgressType.Ring
          })
            .width(100)
          Row() {
            Text(this.finishTask.toString())
              .fontSize(24)
              .fontColor('#36D')
            Text(' / ' + this.totalTask.toString())
              .fontSize(24)
          }
        }
      }.card01()
      .margin({ top: 20, bottom: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)

      Button('新增任务')
        .width(150)
        .margin({ bottom: 10 })
        .onClick(() => {
          this.addTask()
        })

      List() {
        ForEach(this.tasks, (item: Task01, index) => {
          ListItem() {
            Row() {
              if (this.isEditing[index]) {
                Column() {
                  Row() {
                    TextInput({ placeholder: '请输入任务', text: this.inputValue[index] })
                      .onChange((value: string) => {
                        this.todoInfo[index].content = value
                      })
                      .width('60%')
                      .fontWeight(FontWeight.Bold)
                      .margin({ right: 5 })
                    Button('确定')
                      .onClick(() => {
                        TodoModel.AddTodoRequest(this.todoInfo[index])
                          .then((message: TodoShow) => {
                            if (message.code === 1) {
                              console.log('添加成功')
                            } else {
                              console.log('添加失败')
                            }
                          })
                          .catch(error => {
                            console.log(error)
                          })
                        this.displayedValue[index] = this.todoInfo[index].content
                        this.isEditing[index] = false
                        this.TodoList()
                      })
                      .margin({ left: 10 })
                      .width('20%')
                      .height(30)
                      .backgroundColor('#0099ff')
                  }.margin({ top: 10 })//row1

                  Row({space:20}) {
                    Button("选择日期")
                      .width(80)
                      .height(30)
                      .margin({ top: 10})
                      .backgroundColor('#8db6cd')
                      .onClick(() => {
                        DatePickerDialog.show({
                          start: new Date("2024-5-1"),
                          end: new Date("2100-12-31"),
                          selected: this.todoInfo[index].due_date,
                          onAccept: (value: DatePickerResult) => {
                            this.todoInfo[index].due_date.setFullYear(value.year, value.month, value.day)
                            console.log('截止时间:', this.todoInfo[index].due_date.toString())
                          },
                          onCancel: () => {
                            console.info("DatePickerDialog:onCancel()")
                          }
                        })
                      })
                    Button('选择时间')
                      .width(80)
                      .height(30)
                      .margin({ top: 10 })
                      .backgroundColor('#8db6cd')
                      .onClick(() => {
                        TimePickerDialog.show({
                          selected: this.todoInfo[index].due_date,
                          useMilitaryTime: true,
                          onAccept: (value: TimePickerResult) => {
                            this.todoInfo[index].due_date.setHours(value.hour, value.minute)
                            console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
                            console.log("Selected Date and Time after Time Picker:", this.todoInfo[index].due_date.toString())
                          },
                          onChange: (value: TimePickerResult) => {
                            console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
                          }
                        })
                      })
                  }.margin({right:80})//row2
                }
              } else {
                Column() {
                  Text(this.displayedValue[index])
                    .margin({ top: 20 })
                    .fontSize(22)
                    .width('90%')
                  if (this.todoInfo[index]) {
                    Text('截止时间: ' + (this.todoInfo[index]?.due_date
                      ? `${this.todoInfo[index].due_date.getFullYear()}-${(this.todoInfo[index].due_date.getMonth() + 1).toString().padStart(2, '0')}-${this.todoInfo[index].due_date.getDate().toString().padStart(2, '0')} ${this.todoInfo[index].due_date.getHours()}:${this.todoInfo[index].due_date.getMinutes()}`
                      : '未设置'))
                      .margin({ top: 20 })
                      .fontSize(16)
                      .fontWeight('600')
                      .width('90%')
                  }
                }
              }
              Checkbox()
                .select(item.finished)
                .onChange(value => {
                  item.finished = value
                  this.handleTaskChange()

                  TodoModel.UpdateTodoRequest(this.tasks[index].todo_id, value ? 1 : 0)
                    .then((response: TodoUpdate) => {
                      if (response.code === 1) {
                        console.log('代办任务状态更新成功');
                      } else {
                        console.error('代办任务状态更新失败:', response.msg);
                      }
                    })
                    .catch(error => {
                      console.error('代办任务状态更新请求出错:', error);
                    });

                })
            }
            .card01()
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 10 })
          }
          .swipeAction({ end: this.DeleteButton(index) })
        })
      }.width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }.width('100%').height('100%')
    .backgroundColor('#F0F8FF')
    //.backgroundColor('#F1F2F3')
  }

  @Builder DeleteButton(index: number) {
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
      const todoIdToDelete = this.tasks[index].todo_id; // 获取要删除的代办事项的 ID
      TodoModel.DeleteTodoRequest(todoIdToDelete) // 调用 TodoModel 中的删除代办事项的函数
        .then(() => {
          // 删除成功后的处理
          this.tasks.splice(index, 1);
          this.inputValue.splice(index, 1);
          this.displayedValue.splice(index, 1);
          this.isEditing.splice(index, 1);
          this.todoInfo.splice(index, 1); // 更新 todoInfo 数组，删除对应的代办事项
          this.handleTaskChange();
        })
        .catch(error => {
          // 处理删除失败的情况
          console.error('删除代办事项失败:', error);
          // 这里可以添加一些提示或者其他逻辑来处理删除失败的情况
        });
    });
  }
}

