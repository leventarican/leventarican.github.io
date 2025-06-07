+++
title = "AI: sdk"
date = 2025-06-07
+++

# about 
In this article, I want to give a brief and easy overview of how to use Vercel's AI SDK for building AI-powered applications.

In this example, I'll use Anthropic, but it should also work without an API key. So, with a gateway, you can communicate and use different LLM providers in a provider-agnostic way.

```bash
npm install ai
npm install @ai-sdk/anthropic
npm install dotenv

# create .env variable for environment variable
# ANTHROPIC_API_KEY=...
```

# the-app
```js 
import 'dotenv/config';
import { anthropic } from '@ai-sdk/anthropic';
import { generateText } from 'ai';

async function main() {
  const { text } = await generateText({
    model: anthropic('claude-3-haiku-20240307'),
    prompt: 'Write a short poem about coding',
  });

  console.log(text);
}

main().catch(console.error);
```

Output
```
Here is a short poem about coding:

Coding, a dance of logic and grace,
Weaving lines of code, a digital lace.
Algorithms and syntax, a symphony to behold,
Transforming ideas into stories untold.

Pixels and bytes, the canvas of our time,
Crafting solutions, a masterpiece sublime.
From the depths of the screen, a world takes shape,
Coding, the language that helps us escape.

Endless possibilities, a universe to explore,
With each line of code, we unlock so much more.
Coding, the art of creating, the power to inspire,
A journey of discovery, a never-ending desire.
```
