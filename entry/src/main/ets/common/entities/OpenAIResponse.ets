import {Message} from "./Message"
export  interface OpenAIResponse {
  choices: Choice[];
  object: string;
  usage: Usage;
  created: number;
  system_fingerprint: SystemFingerprint;
  model: string;
  id: string;
}

interface Choice {
  message: Message;
  finish_reason: string;
  index: number;
  logprobs: LogProbs;
}



interface Usage {
  prompt_tokens: number;
  completion_tokens: number;
  total_tokens: number;
  prompt_tokens_details: PromptTokensDetails;
}

interface PromptTokensDetails {
  cached_tokens: number;
}

interface LogProbs {
  tokens: string[];
  token_logprobs: number[];
  top_logprobs: Record<string, number>[];
  text_offset: number[];
}

interface SystemFingerprint {
  os: string;
  version: string;
  architecture: string;
}