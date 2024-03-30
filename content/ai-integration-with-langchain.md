+++
title = "AI: Integration with LangChain.js"
date = 2024-03-26
+++

# About
In the world of programming, integrating artificial intelligence (AI) into your projects can seem daunting. However, with the right tools and a bit of guidance, it can be a straightforward and rewarding process. In this article, we'll explore how to use Langchain with OpenAI to add AI capabilities to your applications.

NOTE that instead of openai other LLM's can be used.
* Groq
* Ollama (local)

# What is Langchain
Langchain is a library that simplifies the process of integrating AI models, like those provided by OpenAI, into your applications. It provides a set of tools that make it easier to send messages to AI models and interpret their responses.

# Getting started
To begin, you'll need to set up your development environment. This involves installing necessary packages and setting up environment variables. We'll be using Deno, a modern runtime for JavaScript and TypeScript, to run our example

# Step 1: install deno
Deno is a secure runtime for JavaScript and TypeScript that is built on V8, the same engine that powers Google Chrome.

> Since version 1.28, Deno has native support for importing npm packages. This is done by importing using npm: specifiers.
* source: https://docs.deno.com/runtime/manual/node/npm_specifiers

Example `packages.json`. We use here ES module instead of javascript module.
```json
{
  "type": "module",
  "dependencies": {
    "chalk": "^5.3.0",
    "dotenv": "^16.4.5",
    "langchain": "^0.1.30"
  }
}
```

# Step 2: install packages
Once Deno is installed, you'll need to install a few npm packages:
* dotenv: To manage environment variables.
* langchain: The main library we'll be using to interact with OpenAI.
* chalk: A library for adding color to console output.

Install these packages:
```bash
npm i dotenv
npm i langchain
npm i chalk
```

# Step 3: set up `.env` file
Create a .env file in your project directory and add your OpenAI API key:
```bash
OPENAI_API_KEY=your_openai_api_key_here
```
Make sure to replace your_openai_api_key_here with your actual API key from OpenAI.

# Step 4: write code
Now, let's write some TypeScript code to use Langchain with OpenAI. Save the following code as langchain-openai.ts:
```js
import chalk from "chalk";
import "dotenv/config";
import { ChatOpenAI } from "npm:@langchain/openai";
import { HumanMessage } from "npm:@langchain/core/messages";

console.log("# START    ");

// will use default env name OPENAI_API_KEY which is defined in .env
const model = new ChatOpenAI({
    modelName: "gpt-3.5-turbo-1106",
    temperature: 0.9,
});

const response = await model.invoke([
    new HumanMessage("write kotlin hello world.")
]);

console.log(chalk.bgGreenBright(response.content));

console.log("# END");
```
This script initializes the Langchain model, sends a message to the AI asking it to write a "Hello, World!" program in Kotlin, and then prints the AI's response with a green background.

# Step 5: run code
To run your script, use the following command:
```bash
deno run --allow-env --allow-sys --allow-read --allow-net langchain-openai.ts

# START
fun main() {
    println("Hello, World!")
}
# END
```

# Links
* https://api.js.langchain.com/classes/langchain_openai.ChatOpenAI.html