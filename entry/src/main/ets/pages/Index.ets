import {  promptAction } from '@kit.ArkUI';
import {Message} from "../common/entities/Message"
import Constants from "../common/constants/ConstantsDev"
import {makeChat} from "../api/OpenAIChat"

/**
 * 消息类型
 */



@ObservedV2
class messageType {
  role: string
  @Trace context: string

  constructor() {
    this.role = 'user'
    this.context = ''
  }
}


@Preview
@ComponentV2
@Entry
export struct MainPage {
  @Local scrollHeight: number = 0
  userInputMessage : Message  = {role:"user",content:""};
  MessageList : Message[] = [];



  bgc: string = '#C8EE9D'
  TextAreaController: TextAreaController = new TextAreaController()
  listScroller: Scroller = new Scroller()

  /**
   * 消息列表:messageType[]
   */
  @Local messages: messageType[] = [
    { role: 'assistant', context: "hello"  },
  ]
  /**
   * 输入框内容:string
   */
  @Local inputValue: string = ''
  /**
   * 模拟的回复数据
   */
  allReplyMessages: string[] = [
    '你好，我是arkui，你可以向我提问任何问题',
  ]

  testReply : string = "";
  /**
   * 页面展示
   */
  onPageShow() {

    this.changeScrollHeight()
  }
  async  aboutToAppear(): Promise<void> {

    //this.currentID = AppStorageV2.connect(ConversationID,() => new ConversationID())!

    //console.log("chat inspect in chat",JSON.stringify(this.currentID))

  }
  /**
   * 改变输入框的Scroll容器的高度
   */
  changeScrollHeight() {
    console.log('zxxcxf--', this.TextAreaController.getTextContentLineCount())
    let line = this.TextAreaController.getTextContentLineCount()
    if (line === 0 || line == 1) {
      this.scrollHeight = 50
      return
    }
    if (line > 4) {
      this.scrollHeight = 100
    } else {
      this.scrollHeight = 20 * line + 20
    }
  }

  /**
   * 发送消息
   */
  sendMessage() {
    if (this.inputValue.trim() === '') {
      promptAction.showToast({
        message: '请输入内容',
        duration: 1500
      })
      return
    }
    this.messages.push({ role: 'user', context: this.inputValue })

    //data.input.prompt = this.inputValue;
    this.userInputMessage = { role: 'user', content: this.inputValue }
    this.MessageList.push(this.userInputMessage)
    this.inputValue = ''
    this.changeScrollHeight()
    this.listScroller.scrollEdge(Edge.Bottom)
    this.replyMessage()
  }

  /**
   * 回复消息
   */
  async  replyMessage() {
    this.messages.push({ role: 'assistant', context: 'Waiting for response.....' })
    let index = 0;

    let reply = await makeChat({model:Constants.MODEL},this.MessageList);
    this.MessageList.push(reply);

    this.typer(index, reply.content)

  }

  /**
   * 打字机
   * @param index
   * @param reply
   */
  typer(index: number, reply: string) {
    if (index > reply.length) {
      return
    }
    setTimeout(() => {
      // this.messages[this.messages.length - 1].context = reply.substring(0, index)
      this.messages[this.messages.length - 1] = {
        role: 'assistant',
        context: reply.substring(0, index)
      }
      index++;
      this.typer(index, reply)
      this.listScroller.scrollEdge(Edge.Bottom)
      console.log('zxxcxf--' + this.messages[this.messages.length - 1].context)
    }, 50)
  }

  build() {
    Column() {
      //聊天区域
      Column() {
        List({
          space: 10,
          initialIndex: this.messages.length - 1,
          scroller: this.listScroller
        }) {
          ForEach(this.messages, (message: messageType, index: number) => {
            ListItem() {
              Row() {
                Image(message.role === 'user' ? $r('app.media.me') : $r('app.media.chat'))
                  .width(40)
                  .aspectRatio(1)
                Row() {
                  Text(message.context)
                    .backgroundColor(message.role === 'user' ? '#9489CD' : '#FDF8FF')
                    .fontSize(20)
                    .fontColor('#1C1B21')
                    .padding(10)
                    .textAlign(TextAlign.Start)
                    .borderRadius(10)
                }
                .justifyContent(message.role === 'user' ? FlexAlign.End : FlexAlign.Start)
                .layoutWeight(1)
              }
              .alignItems(VerticalAlign.Top)
              .width('100%')
              .reverse(message.role === 'user')
            }
          })
        }
        .padding({
          top: 10,
          bottom: 10,
          left: 10,
          right: 10
        })
      }
      .backgroundColor(this.bgc)
      .layoutWeight(1)
      .width('100%')

      // 输入框
      Row() {
        TextArea({
          placeholder: '请输入内容',
          text: $$this.inputValue,
          controller: this.TextAreaController
        })
          .height('100%')
          .margin(0)
          .layoutWeight(1)
          .fontSize(20)
          .lineHeight(30)
          .enterKeyType(EnterKeyType.Send)
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.changeScrollHeight()
          })
          .onSubmit(() => {
            this.sendMessage()
          })
        Image($r('app.media.top'))
          .width(50)
          .aspectRatio(1)
          .fillColor(this.inputValue === '' ? Color.Gray : Color.Black)
          .onClick(() => {
            this.sendMessage()
          })
      }
      .width('100%')
      .height(this.scrollHeight || 50)//作为子组件时的备用措施
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft: 20,
        topRight: 20
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgc)
  }
}
