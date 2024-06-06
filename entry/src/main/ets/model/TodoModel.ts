import http from '@ohos.net.http';
import PreferencesUtil from '../util/preferencesUtil'
import TodoInfo,{TodoShow,TodoData} from '../viewmodel/TodoInfo'
class TodoModel{
  baseURL: string = 'http://172.16.24.50:8080';
  async AddTodoRequest(TodoInfo:TodoInfo) {
    let id = TodoInfo.employee_id
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number

    const year = TodoInfo.due_date.getFullYear();
    const month = (TodoInfo.due_date.getMonth() + 1).toString().padStart(2, '0'); // 月份从0开始，所以需要+1
    const day = TodoInfo.due_date.getDate().toString().padStart(2, '0');
    const hours = TodoInfo.due_date.getHours().toString().padStart(2, '0');
    const minutes = TodoInfo.due_date.getMinutes().toString().padStart(2, '0');

    console.log('Retrieved employee_id:', id)
    const requestBody = {
      employee_id:id,
      content: TodoInfo.content,
      due_date:`${year}-${month}-${day} ${hours}:${minutes}:00`
    };

    console.log('发送的请求体：', JSON.stringify(requestBody).toString());

    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/addTodo`,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify(requestBody)
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString());
          resolve(result);
        } else {
          console.log('http--失败1', resp.result);
          reject('添加代办失败');
        }
      }).catch(error => {
        console.log('添加代办失败error(catch):', JSON.stringify(error));
        reject('添加代办失败');
      });
    });
  }

  async ShowTodoRequest() {

    let id = 0
    id = await PreferencesUtil.getPreferenceValue('User','employee_id',0) as number
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.request(
        `${this.baseURL}/showTodo/${id}`,
        {
          method: http.RequestMethod.GET,
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          console.log('http--成功', resp.result);
          const result = JSON.parse(resp.result.toString())
          if (result.code === 1) {
            resolve(result.data);
          } else {
            console.log('请求成功但响应有误', result);
            reject('获取代办事项失败');
          }
        } else {
          console.log('http--失败1', resp.result);
          reject('获取代办事项失败');
        }
      }).catch(error => {
        console.log('获取代办事项失败error(catch):', JSON.stringify(error));
        reject('获取代办事项失败');
      });
    });
  }

   UpdateTodoRequest(todo_id: number, is_completed: number) {
    return new Promise((resolve, reject) => {
      // 构造请求的 URL
      const url = `${this.baseURL}/updateTodo/${todo_id}/${is_completed}`;

      // 设置请求的参数
      const requestData = {
        method: http.RequestMethod.PUT
      };

      // 发起请求
      let httpRequest = http.createHttp();
      httpRequest.request(url, requestData)
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('http--成功', resp.result);
            const result = JSON.parse(resp.result.toString());
            if (result.code === 1) {
              resolve(result.data);
            } else {
              console.error('请求成功但响应有误', result);
              reject('更新代办事项失败');
            }
          } else {
            console.error('HTTP请求失败:', resp.result);
            reject('更新代办事项失败');
          }
        })
        .catch(error => {
          console.error('更新代办事项失败:', error);
          reject('更新代办事项失败');
        });
    });
  }
  DeleteTodoRequest(todo_id: number) {
    return new Promise((resolve, reject) => {
      const url = `${this.baseURL}/deleteTodo/${todo_id}`;
      const requestData = {
        method: http.RequestMethod.DELETE
      };

      let httpRequest = http.createHttp();
      httpRequest.request(url, requestData)
        .then(resp => {
          if (resp.responseCode === 200) {
            console.log('http--成功', resp.result);
            const result = JSON.parse(resp.result.toString());
            if (result.code === 1) {
              resolve(result.data);
            } else {
              console.error('请求成功但响应有误', result);
              reject('删除代办事项失败');
            }
          } else {
            console.error('HTTP请求失败:', resp.result);
            reject('删除代办事项失败');
          }
        })
        .catch(error => {
          console.error('删除代办事项失败:', error);
          reject('删除代办事项失败');
        });
    });
  }
}
const todoModel = new TodoModel();
export default todoModel;