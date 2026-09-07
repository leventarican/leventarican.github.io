+++
title = "AI: Agentic Coding"
date = 2026-08-02
+++

# About
Two small experiments, same underlying questions, two different languages. One is a JavaScript "ad copy writer" built with LangChain/LangGraph/LangSmith, the other a Python "support email classifier" built with Pydantic/PydanticAI. Neither does anything useful on its own — they exist to isolate two ideas that keep coming up once you write actual code around an LLM instead of just chatting with one.

# The two questions that matter
Once an LLM call is wired into a program instead of a chat window, two questions turn out to matter more than which framework logo is on the box: who decides what happens next, and can you trust the shape of what comes back? The first is the difference between a **workflow** and an **agent**. The second is what "structured output" is actually for. Both experiments below are really just these two questions, poked at from two languages.

# Workflow vs. agent, same task twice
The JS project writes an advertising blurb for a product, checks it against a word limit and a list of banned words, and revises it until it passes — twice, with the exact same tools, once as a workflow and once as an agent.

As a **workflow** (`main.js`), the control flow is a plain function:

```js
if (woerter > MAX_WOERTER) {
  // zurück zum Writer, mit der Fehlermeldung als Anweisung
}
```

*You* wrote that `if`. The LLM only ever fills in text; every decision about what happens next lives in your code.

As an **agent** (`agent.js`), the same task is handed to the model together with three tools — `zaehle_woerter` (count words), `pruefe_richtlinien` (check banned words), `speichere_werbetext` (save the result) — and a system prompt describing the procedure. The routing function looks almost the same as the workflow's `if`, except it's now reading a decision instead of making one:

```js
function routeAgent(state) {
  const letzte = state.messages.at(-1);
  if (letzte.tool_calls?.length) return "werkzeuge"; // model asked for a tool
  return END;                                        // model is done
}
```

That's the entire difference between the two files: in the workflow, the condition inspects data your code computed. In the agent, the condition inspects what the *model* decided to do next. Both are built on the same LangGraph mechanism underneath — a state, nodes, a conditional edge, and a cycle back from the tool node to the model node so it can see the tool result and decide again. A `recursionLimit` acts as a safety net against a model that never stops asking for tools.

One thing that surprised me: a graph earns its keep even without multiple agents. `main.js` has zero agents and still needs a cycle — LangChain alone (no graph) can't express "go back and try again" — so the useful distinction isn't "how many agents" but "is the flow cyclic, and who's steering it."

# Forcing the model to answer in a shape you can use
The Python project answers a different half of the same problem: getting the model to return something your code can rely on without hand-parsing text. A classic `pydantic.BaseModel` first validates the raw input (does `sender` look like an email address, is `subject` non-empty) — plain data validation, no AI involved yet:

```python
class IncomingEmail(BaseModel):
    sender: str
    subject: str = Field(..., min_length=1)
    body: str = Field(..., min_length=1)
```

Then a `pydantic_ai.Agent` is given that same kind of model as its `output_type`:

```python
class SupportAnalysis(BaseModel):
    category: Literal["Technical", "Billing", "General", "Complaint"]
    urgency: Literal["low", "medium", "high"]
    sentiment: Literal["positive", "neutral", "negative", "frustrated"]
    draft_reply: str

agent = Agent(model, output_type=SupportAnalysis, system_prompt="...")
result = agent.run_sync(prompt)
```

PydanticAI turns that model into the schema the LLM is constrained to answer in, checks the response against it, and — if the model drifts — pushes back for a correction. The code on the other side never sees free-form text to parse; it gets a `SupportAnalysis` object or an error.

PydanticAI itself is Python-only, though — it doesn't exist in JavaScript. The equivalent idea shows up in the JS project's tool definitions instead, via `zod`:

```js
schema: z.object({ text: z.string().describe("Der zu prüfende Werbetext") }),
```

Same underlying need — force the model's output into something type-checked instead of a string you `JSON.parse` and hope — just solved per-tool with `zod` rather than for a whole agent's final answer with a Pydantic model.

# A few things that only show up once you actually run it
* **Small local models can't call tools.** `agent.js` checks this before starting: `gemma2:2b` runs fine for the plain workflow, but the agent variant needs tool-calling support, so a small model just fails deep inside the run with a raw 400 error unless you check first and tell the user to pull a bigger model.
* **You don't always need a dedicated integration package.** OpenRouter has no `@langchain/openrouter` package — it doesn't need one, since it speaks the same protocol as OpenAI. Pointing the regular `ChatOpenAI` adapter's `baseURL` at OpenRouter is enough, and the same trick works for any OpenAI-compatible endpoint (Groq, Together, a local vLLM server).
* **Tracing doesn't care where the model runs.** LangSmith traces local Ollama runs exactly like it traces Claude or OpenRouter calls — it's just three environment variables, no code change, and switching it off again is just not setting them.
* **Model names go stale fast.** The Python script originally asked for `claude-3-5-sonnet-latest`; by the time it ran, that alias had already been retired in favor of a newer model. Worth pinning a model version somewhere you'll actually notice when it needs updating.

# What's next
Both projects stayed intentionally small — one file each, no framework left unexplained. The natural next step for the workflow/agent side is a task where the workflow version genuinely can't keep up (more than one plausible next step, not just "too long/not too long"), and for the structured-output side, an agent whose tools themselves return typed data instead of just strings, so the whole chain from input to output stays type-checked, not just the ends.
