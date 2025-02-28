## 项目简介
这是基于ArkUI且遵循openai-api接口规范的对话应用Demo

也就是说这个Demo能够支持大部分大模型提供方的api，只要api支持openai-api接口规范

目前实现了最基本的智能体API调用以及对话式输出显示。

支持多轮对话。

操作效果图如下:

![img](https://img2023.cnblogs.com/blog/3416663/202502/3416663-20250210163326062-605433814.gif)





## 存在的问题
### 应用功能上
还有很多功能没有实现

例如：
- 对话记录存储与管理
- 会话管理：实现新建会话窗口功能
- 文本选择以及复制功能
- 编辑已有对话

其中会话管理以及对话记录存储组件已经实现了一部分，但是由于技术上的困难，还需要继续完善，因此未来完善后会将功能合并入此仓库。

此项目的开发仓库连接:https://github.com/mamashende/AIChatDemo-HarmonyOSNext-dev/

此项目的文档兼博客:https://www.cnblogs.com/ouyangzhiyong/p/18743480

如果感兴趣，欢迎star以及fork支持此项目:)

## 如何构建
1.拉取本项目

2.确保ohpm正确安装依赖

3.使用自己的API：


- 如何配置API相关信息：在`entry/src/main/ets/common/constants/`路径下创建`ConstantsDev.ets`文件，按照目录下`Constants.ets`中的格式填入获取到的API信息(包括apikey,url,以及模型的名称)，此文件不会被添加至git存储库，确保个人API使用安全。
- 未来有更好的API管理以及注入方式时，可能会更换API管理方式。





