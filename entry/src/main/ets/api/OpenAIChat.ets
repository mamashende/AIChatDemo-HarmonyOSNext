import {OpenAI} from '@changwei/openai';
import {Model} from "../common/entities/Model"
import {Message} from "../common/entities/Message"
import {OpenAIResponse} from "../common/entities/OpenAIResponse"
import Constants from "../common/constants/ConstantsDev"
//这里是因为引用的参数列表只能按顺序来，因此中间用`""`省略了一个不必要的参数，防止参数错位。
const openai : OpenAI = new OpenAI(Constants.API_KEY,"",Constants.API_URL)

export async function makeChat(model : Model,userMessage : Message[]) : Promise<Message> {
  const result = await openai.chat.completions.create({
    model: model.model,
    messages: userMessage
  })
  // 提取 message 对象
  //const message = result
  // 将返回的数据转换为 JSON 对象
  const resultObject : OpenAIResponse = JSON.parse(JSON.stringify(result));

  // 提取 message 对象
  const message = resultObject.choices[0].message;



  return message
}
