+++
title = "AI: Decision Models"
date = 2026-10-12
+++

# The question

A lot of LLM calls in my code are not really "chat". They are small decisions: which branch, which category, is this urgent, yes or no.
For that I usually ask a big model to answer in JSON and then hope the JSON is valid.
So the question is simple: **is a model that only makes typed decisions a better tool for these small steps than a general LLM?**

# Chat API vs. Decision API

A decision model does not write free text. You give it a state and some typed questions. It returns typed answers with probabilities.

| | Chat API | Decision API |
|---|---|---|
| Input | messages | `state` + named `questions` |
| Output | text (maybe JSON, if the model behaves) | one of the predefined values + probabilities |
| Use in code | parse, validate, retry | `if answer.choice == "shipping": ...` |

The idea comes from Daniel Kahneman: System 1 is fast and intuitive thinking, System 2 is slow and deliberate.
A decision model is the System 1 part: fast, cheap, no reasoning text.

# What is different

* **Input** is structured program state, not a conversation.
* **All answers come in one pass**, not token by token.
* **Output** is always one of the predefined values. There is no invalid JSON and no made-up option.
* **Probabilities are calibrated**: the model is trained so that 0.8 means "right in about 80% of cases".

# Question types

There are three types. One request can mix them, and each question is answered against the same state.

| Type | Asks | Returns |
|---|---|---|
| choice | pick one option | option + probability per option |
| score | rate on an ordered scale | level + probability per level |
| yes/no | is this statement true? | value between 0 and 1 |

A support ticket as example. The request (shortened):

```json
{
  "state": "My order arrived damaged and nobody replied for a week.",
  "questions": {
    "department": {
      "type": "choice",
      "criteria": {
        "billing": "Payment or subscription issues",
        "shipping": "Delivery or product condition problems",
        "sales": "Pricing or account questions"
      }
    },
    "is_urgent": {
      "type": "yes/no",
      "instructions": "The message conveys urgency"
    }
  }
}
```

The answer:

```json
{
  "department": {
    "choice": "shipping",
    "probabilities": { "billing": 0.05, "shipping": 0.82, "sales": 0.13 }
  },
  "is_urgent": 0.95
}
```

The exact field names differ from provider to provider. The shape is the same.

# Confidence decides the next step

The calibrated probability is the interesting part. The code can decide by itself when the small model is good enough.

```text
+-----------+  state + questions  +----------------+
| your code | ------------------> | decision model |
+-----------+                     +----------------+
                                          |
                                          v
                                  +----------------+
                                  |  confidence    |
                                  |  high enough?  |
                                  +----------------+
                                     |          |
                                 yes |          | no
                                     v          v
                          +------------+  +-----------------+
                          | use the    |  | ask a large LLM |
                          | answer     |  | or a human      |
                          +------------+  +-----------------+

        Figure 1: Escalation by confidence
```

Most cases stay fast and cheap. Only the unclear ones go to the slow, expensive path.

Good fit: routing, classification, scoring, yes/no checks. Not a fit: anything that needs generated text or code.

# Without a decision API

A general LLM can do part of this today:

* **Structured output** with an `enum` in the JSON schema forces one of the allowed values.
* **Token logprobs**, where the API returns them, give a rough probability per option.

But these probabilities are not trained to be calibrated. And the model still generates text, so it is slower.

# Examples (October 2026)

* **Jev** from TypeSafe AI: the first "System One Model", September 2026. https://typesafe.ai/blog/introducing-system-one-models-and-jev
* **OpenAI Decisions API** (`/v1/decisions`): followed a few weeks later, same three question types.
* **Laya**: open source decision model (Apache 2.0) that you can self-host.
