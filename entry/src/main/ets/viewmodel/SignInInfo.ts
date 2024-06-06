export default class SignInInfo{
  code: number;
  msg: string;
  data: string;
}
export  interface SignInResponse{
  employee_id:number
  sign_in_time:Date
}
export  interface SignOutResponse{
  employee_id:number
  sign_out_time:Date
}