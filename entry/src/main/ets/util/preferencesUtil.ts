import preferences from '@ohos.data.preferences';
class PreferencesUtil{

  prefMap:Map<string,preferences.Preferences>=new Map()

  async loadPreference(context,name:string){
    try { //加载preferences
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      console.log('testTag',`加载Preferences[${name}]成功`)
    }catch (e){
      console.log('testTag',`加载Preferences[${name}]失败`,JSON.stringify(e))
    }
  }
  async putPreferenceValue(name:string,key:string,value:preferences.ValueType){
    if(!this.prefMap.has(name)){
      console.log('testTag',`加载Preferences[${name}]尚未初始化`)
      return
    }
    let pref = this.prefMap.get(name)
    await pref.put(key,value)
    //刷盘
    await pref.flush()
    console.log('testTag',`保存Preferences[${name}.${key}=${value}]成功`)

  }
  async getPreferenceValue(name:string,key:string,defaultValue:preferences.ValueType){
    if(!this.prefMap.has(name)){
      console.log('testTag',`加载Preferences[${name}]尚未初始化`)
      return
    }
    let pref = this.prefMap.get(name)
    let value= await pref.get(key,defaultValue)

    console.log('testTag',`读取Preferences[${name}.${key}=${value}]成功`)
    return value
  }
}

const preferencesUtil = new PreferencesUtil()

export default  preferencesUtil as PreferencesUtil