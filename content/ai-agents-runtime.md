+++
title = "AI: Agents Runtime"
date = 2026-10-17
+++

# About
Claude Code runs on a laptop. It runs commands and writes files on that laptop. So how does an agent run on a server, for many users, in a safe place? This post follows that question from one layer to the next. At the end, it shows a test of one of these layers on a laptop.

The terms come from [AI: Agents Terms](../ai-agents-terms/).

# The question behind it
An AI agent is a program in which the LLM chooses the next step and uses tools, in a loop. The dangerous part is the tools. A command like `rm -rf` changes the machine where the tool runs. So the real question is: **Where do the tools run, and who controls them?**

# Three parts, two places
A coding agent like Claude Code has three parts:

```text
  laptop                                    provider (cloud)
 +-------------------------------+         +-----------------+
 | harness (loop)                | <-----> |       LLM       |
 |   |                           |  HTTPS  +-----------------+
 |   v                           |
 | tools: shell, files, git      |
 |   -> run on the laptop        |
 +-------------------------------+

        Figure 1: A coding agent on a laptop
```

- The **LLM** does not run on the laptop. It only suggests a step, for example "run `npm test`".
- The **harness** runs on the laptop. It sends text to the LLM and back.
- The **tools** run on the laptop. They change files and run commands.

A sandbox isolates the tools. There are two ways:

1. Put the full harness in a container. The agent sees only the container.
2. Keep the harness outside. Send each tool call to a remote sandbox.

# How a remote agent gets a task
A harness can run without a chat window. Claude Code has a headless mode (`claude -p`). It writes each step as one JSON line. A small server around this process does the rest:

1. The server receives a task over HTTP.
2. The server starts the harness in a sandbox.
3. The server streams each step to the client, for example with Server-Sent Events (SSE).
4. The client shows the steps and asks a person for approvals.

A person does not log in to the sandbox. A person uses a web page, or a system like CI gives the task.

# The layers
For many agents, the work splits into layers. None of the layers is an agent:

```text
            person / client
                  |
   +--------------v---------------+
   | ingress gateway              |  auth, policy, input filter
   +--------------+---------------+
                  |
   +--------------v---------------+
   | harness                      |  loop, context, planning,
   | (Claude Code, ADK, ...)      |  guardrails
   +--------------+---------------+
                  |
   +--------------v---------------+
   | egress gateway               |  allowed models and tools,
   |                              |  credentials, destinations
   +--------------+---------------+
                  |
           LLM API, MCP servers

   below: agent orchestrator (for example AX)
          sandbox runtime (for example Agent Substrate)
          Kubernetes

        Figure 2: Layers around an agent
```

- **Kubernetes** puts containers on machines.
- **Agent Substrate** (open source, started by Google) runs many agent sandboxes on Kubernetes. The project says: it freezes a waiting agent as a snapshot of memory and files, and it continues the agent in less than one second.
- **AX** (Agent Executor, experimental) sits on top of Substrate. It describes agent tasks as Kubernetes-style resources: `Task`, `Workspace`, `Gateway`, `Model`.
- **Gateways** control the traffic. The ingress gateway removes secrets from the input. The egress gateway adds the credentials to each call. So the harness never sees a secret.

Gateways for LLM and MCP traffic already exist, for example LiteLLM Proxy, Envoy AI Gateway and agentgateway.

A gateway does not replace business checks. The agent still needs its own rules and approvals.

# One project on the map
The project from [AI: Agents Reliable](../ai-agents-overview/) runs on one laptop. This is how its parts fit the map:

| Layer | In the project | Not there |
|---|---|---|
| Ingress | console: tasks and approvals; input checks; a rule against prompt injection | authentication |
| Harness | own agent loop, LangGraph graphs | – |
| Egress | MCP to the systems; write tools need an approval; idempotency keys | API keys stay in the agent process |
| Infrastructure | one local process; LangGraph checkpointer in memory | sandbox, durable state |

The gaps are clear: authentication at the ingress, and secrets outside the agent.

# A test on a laptop
The test tried to run Agent Substrate on a laptop with kind (Kubernetes in Docker).

| Part | Version |
|---|---|
| Host | Debian 12, Linux 6.1 |
| kind | v0.33.0, Kubernetes v1.37.0 |
| Agent Substrate | `main` at `05cb6f24` (2026-10-16) |

The result:

- The cluster started. All Substrate pods were `Running`.
- The demo agent did not start. Its status was `GoldenActorCrashed`.
- The cause is in the Substrate code. It mounts overlay file systems with the option `lowerdir+`. This option needs Linux 6.5 or newer. The code says so in a comment.
- kind does not help here. A kind node is a container, and a container uses the kernel of the host.

The lesson: **a container is not a virtual machine.** A sandbox runtime can need a newer kernel than the host has. To continue the test, use a virtual machine with a newer kernel, or a managed cluster.

Not tested: freeze and continue, AX, the gateways.
