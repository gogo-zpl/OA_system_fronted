export default class ChangePasswordInfo{
  id: number
  oldPassword: string
  newPassword: string
}
export interface ChangePasswordResponse{
  code: number;
  msg: string;
  data: string;
}