## 项目简介
这是基于ArkUI且遵循openai-api接口规范的对话应用Demo

![img](https://img2023.cnblogs.com/blog/3416663/202502/3416663-20250210163326062-605433814.gif)



目前实现了最基本的智能体API单轮调用以及对话式输出显示。

## 存在的问题
### 应用功能上
还有很多功能没有实现

例如：
- 对话记录存储与管理
- 多轮对话上下文支持
- 文本选择以及复制功能
- 编辑已有对话
- 会话管理：实现新建会话窗口功能

## 如何构建
1.拉取本项目

2.确保ohpm正确安装依赖

3.使用自己的API：


- 如何配置API相关信息：在`entry/src/main/ets/common/constants/`路径下创建`ConstantsDev.ets`文件，按照目录下`Constants.ets`中的格式填入获取到的API信息，此文件不会被添加至git存储库，确保个人API使用安全。
- 未来有更好的API管理以及注入方式时，可能会更换API管理方式。





