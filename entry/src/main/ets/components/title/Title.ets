/*
 * @author 鼓捣JIA
 * @date 2023/12/03 23:35
 */

import router from '@ohos.router';

@Component
export default struct Title {
  @Prop pageTitle: string


  // 组件的构建函数，用于构建UI界面。
  build() {
    // 使用Stack组件垂直堆叠子组件。
    Stack(){
      // 使用Row组件水平排列子组件，创建标题栏。
      Row() {
        // 使用Text组件显示传入的页面标题。
        Text(this.pageTitle)
          .fontColor($r('app.color.font_main')) // 设置文本颜色，引用资源文件中定义的颜色。
          .fontSize(20) // 设置文本字体大小。
          .fontWeight(700) // 设置文本字体粗细。
      }
      // 设置Row布局属性，使标题居中显示。
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%') // 设置宽度为100%，占满整个屏幕宽度。
      .height(60) // 设置高度为60，标题栏的高度。
      // 再次使用Row组件创建返回按钮和空白占位。
      Row(){
        // 嵌套Row组件，放置返回箭头图标。
        Row(){
          // 使用Image组件加载箭头图标。
          Image($r('app.media.ic_public_arrow_left_filled')) // 图片资源引用。
            .height(32) // 设置图标高度。
            .fillColor($r('app.color.font_main')) // 设置图标的颜色。
        }
        .width(48) // 设置按钮宽度。
        .justifyContent(FlexAlign.Center) // 水平居中对齐图标。
        // 为返回按钮设置点击事件，点击时执行路由返回操作。
        .onClick(()=>{router.back()})
        // 使用Blank组件创建空白占位，用于调整布局。
        Blank()

      }
      .width('100%') // 设置这个Row的宽度为100%。

    }
    // 设置Stack组件的背景颜色。
    .backgroundColor($r('app.color.background_white')) // 引用资源文件中定义的背景颜色。
  }

}