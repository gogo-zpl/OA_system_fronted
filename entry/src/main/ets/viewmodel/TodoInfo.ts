export default class TodoInfo{
  employee_id:number
  content:string
  due_date:Date
}
export interface TodoShow{
  code:number
  msg:string
  data:TodoData
}
export interface TodoData{
  todo_id:number
  employee_id:number
  content:string
  due_date:Date
  is_completed:number
}
export interface TodoUpdate{
  code:number
  msg:string
  data:TodoData
}