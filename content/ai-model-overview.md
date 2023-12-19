+++
title = "AI model's overview"
date = 2023-12-16
+++

In 2023 a lot happend in AI. Here I list the most for me interesting AI models, systems, etc.

NOTE: This page is dynamic.

Table of contents:
* [xAI](#xai)
* [pi](#pi)
* [claude](#claude)
* [poe](#poe)
* [openai](#openai)
* [llamafile](#llamafile) 
* [uncategorized](#uncategorized)
*
# xAi
AI from x.com aka. grok.

* https://x.ai/ide/docs

# claude
Anthropic's model. Currently not available european countries.
Anthropic’s Claude models can also used with Amazon Bedrock API.

* https://claude.ai 
* https://docs.anthropic.com/claude/reference/claude-on-amazon-bedrock

# poe
Poe is a neutral platform. You can access different providers (OpenAI, Anthropic, Google, and open source models like Llama 2 or SDXL).

* https://developer.poe.com

# pi
Currently no developer API.

* https://pi.ai
* https://inflection.ai/

# google
Aside the known google bard. Google provides gemini (ultra, pro and nano). Nano is dedicated for mobile systems.
Pro is already available.

* https://ai.google.dev/
* https://idx.dev/

# openai
OpenAI API provides various models for app integration.

| **Category**         | **Model Type**                | **Models**                       |
|----------------------|-------------------------------|----------------------------------|
| Language Models      | GPT-4 Turbo                   | gpt-4-1106-preview               |
|                      |                               | gpt-4-1106-vision-preview        |
|                      | GPT-4                         | gpt-4                            |
|                      |                               | gpt-4-32k                        |
|                      | GPT-3.5 Turbo                 | gpt-3.5-turbo-1106               |
|                      |                               | gpt-3.5-turbo-instruct           |
| Assistants API (Tools)|                              | Retrieval                        |
|                      |                               | Code interpreter                 |
| Fine-tuning Models   |                               | gpt-3.5-turbo                    |
|                      |                               | davinci-002                      |
|                      |                               | babbage-002                      |
| Embedding Models     |                               | ada v2                           |
| Base Models          |                               | davinci-002                      |
|                      |                               | babbage-002                      |
| Other Models         | Image Models                  | DALL·E 3                         |
|                      | Audio Models                  | Whisper (speech-to-text)         |
|                      |                               | TTS (text-to-speech)             |
|                      |                               | TTS HD                           |

Sidenote regarding __ada v2__ and embeddings: Posted by @karpathy on X.
> LLM OS. Bear with me I'm still cooking.
> Specs:
> - LLM: OpenAI GPT-4 Turbo 256 core (batch size) processor @ 20Hz (tok/s)
> - RAM: 128Ktok
> - Filesystem: Ada002

## Assistants API
The Assistant's API allows you to create agent-based applications using our text generation models.

The assistans api consists of tools: 
* code interpreter: AI can run and write code i.e. when you provide.
* retrieval: use your internal knowledge base.
* functions calling: describe custom functions of app as well as external APIs.

__Function calling__ allows developers to more reliably get structured data back from the model. 
> Source: https://openai.com/blog/function-calling-and-other-api-updates

Learn how to connect large language models to external tools.
> https://platform.openai.com/docs/guides/function-calling

## Custom GPTs
From November 2023, OpenAI's ChatGPT introduces the ability to create bespoke GPT models. Anticipated shortly is the launch of a specialized store for these models.

Currently ChatGPT offers a way to create a GPT
> Customize a version of ChatGPT for specific purpose.

Enhancing Security in Custom GPT Model Creation

When creating custom GPT models, it's crucial to safeguard against prompt injections that could reveal sensitive instructions. To enhance security, employ mechanisms like 'rules' or a 'seed hash'. During the creation process, you can generate a unique seed hash. This seed hash acts as a key; only those who possess it can access or view the specific instructions of the model.

This approach ensures that your custom GPT model remains secure and its usage is controlled, thereby maintaining the integrity and confidentiality of your application.

## Links
* https://platform.openai.com/docs/assistants
* Assistants API tools: https://platform.openai.com/docs/assistants/tools
* https://platform.openai.com/playground > Assistants
* GPT-4V(ision) system card: https://openai.com/research/gpt-4v-system-card
* OpenAI DevDay, Opening Keynote: https://www.youtube.com/watch?v=U9mJuUkhUzk
* https://openai.com/blog/introducing-gpts

# llamafile
Powered by mozilla. It combines `llama.cpp` with `cosmopolitan` to make a single file executable. Either in console or browser.
* https://hacks.mozilla.org/2023/11/introducing-llamafile/
* https://github.com/Mozilla-Ocho/llamafile

# uncategorized
* Amber model and CrystalCoder model (completely open source ?) - https://www.llm360.ai/
* JetBrains AI - https://www.jetbrains.com/de-de/ai/
* nanoGPT - https://github.com/karpathy/nanoGPT, https://lambdalabs.com/ 
* the github for ML models - https://huggingface.co
* https://stability.ai/
* https://brev.dev/
* run AI models - https://modal.com/docs/examples/doc_ocr_jobs
* deploy apps and nextJS - https://vercel.com
* generate user interface with AI, by vercel - https://v0.dev/faq
* https://supabase.com

