export default class RegisterInfo{
  name:string
  department_name:string
  account:string
  password:string
  position:string
  phone_number:string
  birthday:Date
  id_card:string
  hire_date:Date
}
export interface  RegisterResponse {
  code: number;
  msg: string;
  data: string;
}