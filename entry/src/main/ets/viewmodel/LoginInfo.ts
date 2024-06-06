export interface EmployeeData {
  employee_id: number;
  name: string;
  department_id: number;
  position: string;
  phone_number: string;
  id_card: string;
  birthdate: Date;
  is_regular_employee: number;
  hire_date: Date;
  password: string;
  account: string;
  permission: number;
  department_name: string;
}

export default class  LoginResponse {
  code: number;
  msg: string;
  data: EmployeeData;
}
export interface loginInfo{
  account:string
  password:string
  permission:0
}