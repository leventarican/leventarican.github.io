+++
title = "AI: Agents Terms"
date = 2026-10-16
+++

# About
Many people use the words "AI", "agent" and "AI agent" for very different things. A chat window gets the same name as a system that pays money. This post gives each word one meaning. It also gives one question that separates the words.

The examples come from the project in [AI: Agents Reliable](../ai-agents-overview/).

# The question behind it
Somebody says: "We use an AI agent." What does that mean? It can be a chat window. It can be a fixed program with one LLM call. It can be a program that chooses its own steps and changes data. These three things have different risks. So they need different names.

# The levels

| Term | In one sentence | Example |
|---|---|---|
| **AI** | Generic term for software that learns from data. | spam filter, image recognition, ChatGPT |
| **LLM** (language model) | Text in, text out. Nothing else. | the model behind ChatGPT or Claude |
| **Chat assistant** | An LLM with a user interface. A person asks and reads. | ChatGPT in the browser |
| **Workflow with an LLM** | The steps are fixed. The LLM does some of the steps. | Clara: read (LLM), check (code), decide (code) |
| **AI agent** | A program in which the LLM chooses the next step and uses tools, in a loop. | Claude Code, Olive |
| **Multi-agent system** | Several agents or workflows share one task. | Olive, Penny, Clara, and Hugo through A2A |

In the overview post, "loop" means agent and "graph" means workflow.

# One question separates them

> **Who decides the next step: a person, the code or the model?**

```text
              Who decides the next step?
                          |
        +-----------------+-----------------+
        |                 |                 |
        v                 v                 v
   +---------+      +-----------+     +-----------+
   | person  |      |   code    |     |   model   |
   +---------+      +-----------+     +-----------+
        |                 |                 |
        v                 v                 v
  chat assistant    workflow with       AI agent
                      an LLM

        Figure 1: One question, three terms
```

A workflow is easier to test and to explain than an agent. So use a workflow where possible. Use an agent only where the steps are not known before.

# Same technology, different use
Claude Code and Clara both use an LLM, tools and a loop or a graph. But they do different jobs.

| | Coding agent | Business agent |
|---|---|---|
| Examples | Claude Code, OpenCode, Copilot CLI | Clara, Penny, Olive |
| Job | general: write code, edit files, run commands | one business task: check a claim, sort the mail |
| Tools | general: shell, files | business: read member data, pay, send a letter |
| Who uses it | a developer | a person in the business team |

A developer uses a coding agent to build a business agent.

# Parts that are not an agent
Some words name a part of an agent, not an agent:

- **Harness**: the program around the LLM: loop, tools, permissions, context. Agent = model + harness.
- **Skill**: a folder with a `SKILL.md` file. The agent reads it when the task needs it.
- **MCP**: the connection from an agent to a system.
- **A2A**: the connection from an agent to the agent of another company.

A tool like `npx skills add` only copies a skill folder into the folder that the coding agent reads. The agent gets new instructions to read. It does not get a new ability.

# Four questions for each meeting
If somebody says "AI agent", ask these questions:

1. Who decides the next step?
2. Which tools can it use: only read, or also write?
3. Who approves a change before it happens?
4. How do you know that it works? What do you measure?
