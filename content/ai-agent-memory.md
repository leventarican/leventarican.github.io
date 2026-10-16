+++
title = "AI: Agent Memory"
date = 2026-10-12
+++

# The question

Every new agent session starts from zero. I tell Claude Code the same things again and again, or I write them into a `CLAUDE.md` by hand.
So my question: **can a memory layer remember this for me, without me having to curate files myself?**
And a second one: what does "memory" for an agent actually mean technically?

# Memory is text in the context

An LLM has no memory of its own. Each call only knows the text in its context window.
So "memory" means: put the right text into the context at the right time.

```text
+--------------+   always              +------------------------+
| CLAUDE.md    | --------------------> | context window         |
+--------------+                       |                        |
                                       |  instructions          |
+--------------+   description,        |  skill descriptions    |
| SKILL.md     | --------------------> |  (skill content)       |
+--------------+   content on demand   |  memory entries        |
                                       |  conversation          |
+--------------+   matching entries    |                        |
| memory files | --------------------> |                        |
+--------------+                       +------------------------+
                                                   |
                                                   v
                                              +---------+
                                              |   LLM   |
                                              +---------+

        Figure 1: What goes into the context for one call
```

* **Instruction files** (`CLAUDE.md`, `AGENTS.md`): always loaded, written by hand. Simple, but every line costs tokens in every session.
* **Skills** (`SKILL.md`): only the description is always loaded. The agent loads the content when the task needs it.
* **Auto memory**: the agent itself decides what to keep and writes it to a file.

All three are plain Markdown on disk. You can read, edit and commit them.

Skills can hold more than facts. They can also hold a way of working. For example, [agent-skills](https://github.com/addyosmani/agent-skills) gives a coding agent workflows for spec, plan, test, review and ship.

Inside one long session the context also fills up. Agents then replace old turns with a summary (compaction), or move verbose tool output to disk and keep only a short reference.

# Memory layers

Automatic long-term memory systems often use layers. Lower layers keep the evidence, upper layers keep the structure.

| Layer | Content |
|---|---|
| L0 Conversation | raw conversations, full context |
| L1 Fact | single facts, preferences, constraints |
| L2 Topic | knowledge per project or topic |
| L3 Profile | long-term profile and stable patterns |

The system saves each conversation as L0 first. A second LLM builds L1 - L3 from it in the background.
The agent reads the upper layers first. If it must check something, it goes back down to L0.

```text
  read                 +-------------+                  write
  (start at top)       | L3 Profile  |         (LLM, in background)
     |               +-+-------------+-+                ^
     |               |    L2 Topic     |                |
     |             +-+-----------------+-+              |
     |             |       L1 Fact       |              |
     |           +-+---------------------+-+            |
     v           |     L0 Conversation     | -----------+
  (only to       +-------------------------+
   check)                     ^
                              |
                      new conversation

        Figure 2: Memory layers, write path and read path
```

The second LLM costs money, and the extracted facts can be wrong.

To find the relevant entries, most systems use hybrid search: BM25 for exact words, vector search for meaning, and RRF to merge both result lists.

# Integration

A memory system connects to an agent in one of two ways:

* **Plugin or MCP server**: the agent calls memory tools on purpose.
* **Proxy**: the agent's base URL points to the proxy instead of the LLM provider. The agent does not know about the memory.

```text
+-------+  request   +-------+  request + memory  +-----+
| agent | ---------> | proxy | -----------------> | LLM |
|       | <--------- |       | <----------------- |     |
+-------+  response  +-------+      response      +-----+
                       |   ^
          save request |   | relevant entries
          and response v   |
                     +--------+
                     | memory |
                     +--------+

        Figure 3: Memory proxy between agent and LLM
```

The proxy works with any agent that lets you change the base URL. But you see less of what goes into the context.

A memory can also be shared in a team. Then it holds skills, docs and code structure next to chat facts, and each entry has a visibility (`private`, `team`, ...).

# Example: TencentDB Agent Memory

TencentDB Agent Memory (open source, 2026) uses the L0 - L3 layers, hybrid search, a proxy and team memory.

* Repo: https://github.com/TencentCloud/TencentDB-Agent-Memory
