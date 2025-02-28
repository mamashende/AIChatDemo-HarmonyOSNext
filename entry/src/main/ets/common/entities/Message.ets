import {Role} from "./Role"

export interface Message {
  role: Role;
  content: string;
}