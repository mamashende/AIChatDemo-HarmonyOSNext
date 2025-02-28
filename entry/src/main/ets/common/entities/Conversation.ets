import {Message} from "./Message"
export interface Conversation {
  id: string;
  title : string;
  messages: Message[];
  createdAt: string;
  updatedAt: string;
}