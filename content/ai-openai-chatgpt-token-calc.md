+++
title = "AI: - OpenAI ChatGPT API pricing calculation"
date = 2023-09-14
+++

# About
This document gives an explanation of how the token price is calculated.

> Counting tokens for chat completions API call.

We take as an example the language model _GPT-3.5 Turbo_.

| Model       | Input                | Output               |
|-------------|----------------------|----------------------|
| 4K context  | $0.0015 / 1K tokens  | $0.002 / 1K tokens   |
| 16K context | $0.003 / 1K tokens   | $0.004 / 1K tokens   |

> To see how many tokens are in a text string without making an API call, you can use OpenAI’s tiktoken Python library.
Source: https://help.openai.com/en/articles/7232945-how-can-i-use-the-chatgpt-api

# Calculation

When using the ChatGPT API, the cost is determined by two main factors: the number of tokens in the input and the number of tokens in the output. Each token has a specific price based on the model you're using.

## Example Request

Here's the Python request we made to the ChatGPT API:

```python
import openai

completion = openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
  ]
)
```

## Example Response

```json
{
  "id": "...",
  "object": "chat.completion",
  "created": 1694725384,
  "model": "gpt-3.5-turbo-0613",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "How can I assist you today?"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 13,
    "completion_tokens": 7,
    "total_tokens": 20
  }
}
```

From the response, we can see that:

Input tokens used: 13
Output tokens generated: 7
Total tokens: 20
Breaking down the cost:

1. Input Tokens:
    * Cost for our input: (13 tokens / 1000) * $0.0015 = $0.0000195
2. Output Tokens:
    * Cost for our output: (7 tokens / 1000) * $0.002 = $0.000014
3. Total Cost:
    * Total cost: $0.0000195 (input) + $0.000014 (output) = $0.0000335

So, for our example call with a total of 20 tokens, the cost would be $0.0000335.

## Example code

> Models don't see text like you and I, instead they see a sequence of numbers (known as tokens).

> ChatGPT models like gpt-3.5-turbo and gpt-4 use tokens in the same way as older completions models, but because of their message-based formatting, it's more difficult to count how many tokens will be used by a conversation.

```python
# tiktoken is a fast BPE tokeniser for use with OpenAI's models.
import tiktoken

# load correct encoding: <Encoding 'cl100k_base'>
encoding = tiktoken.encoding_for_model("gpt-3.5-turbo-0613")
print(encoding)
# output: <Encoding 'cl100k_base'>

messages = [
    {"role": "system", "content": "You are a helpful assistant."}
]

encoded = encoding.encode(messages[0]['content'])
print(encoded)
# output: [2675, 527, 264, 11190, 18328, 13]
# result is 6 tokens

def num_tokens_from_messages(messages, model="gpt-3.5-turbo-0613"):
    """Return the number of tokens used by a list of messages."""
    try:
        encoding = tiktoken.encoding_for_model(model)
    except KeyError:
        print("Warning: model not found. Using cl100k_base encoding.")
        encoding = tiktoken.get_encoding("cl100k_base")
    if model in {
        "gpt-3.5-turbo-0613",
        "gpt-3.5-turbo-16k-0613",
        "gpt-4-0314",
        "gpt-4-32k-0314",
        "gpt-4-0613",
        "gpt-4-32k-0613",
        }:
        tokens_per_message = 3
        tokens_per_name = 1
    elif model == "gpt-3.5-turbo-0301":
        tokens_per_message = 4  # every message follows <|start|>{role/name}\n{content}<|end|>\n
        tokens_per_name = -1  # if there's a name, the role is omitted
    elif "gpt-3.5-turbo" in model:
        print("Warning: gpt-3.5-turbo may update over time. Returning num tokens assuming gpt-3.5-turbo-0613.")
        return num_tokens_from_messages(messages, model="gpt-3.5-turbo-0613")
    elif "gpt-4" in model:
        print("Warning: gpt-4 may update over time. Returning num tokens assuming gpt-4-0613.")
        return num_tokens_from_messages(messages, model="gpt-4-0613")
    else:
        raise NotImplementedError(
            f"""num_tokens_from_messages() is not implemented for model {model}. See https://github.com/openai/openai-python/blob/main/chatml.md for information on how messages are converted to tokens."""
        )
    num_tokens = 0
    for message in messages:
        num_tokens += tokens_per_message
        for key, value in message.items():
            num_tokens += len(encoding.encode(value))
            if key == "name":
                num_tokens += tokens_per_name
    num_tokens += 3  # every reply is primed with <|start|>assistant<|message|>
    return num_tokens

num_tokens = num_tokens_from_messages(messages, model="gpt-3.5-turbo-0613")
print(num_tokens)
# output: 13
```

# Sources
* https://openai.com/pricing
* https://github.com/openai/tiktoken
* https://github.com/openai/openai-cookbook/blob/main/examples/How_to_count_tokens_with_tiktoken.ipynb
