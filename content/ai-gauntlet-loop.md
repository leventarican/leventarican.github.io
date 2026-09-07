+++
title = "AI: Gauntlet Loop"
date = 2026-07-20
+++

# About
"Gauntlet Loop" is a name Matt Shumer put on an agent pattern in late July 2026, after using it to produce a browser-based shooter game from a single orchestration prompt. I wanted to see the idea itself, not the game demo, so I built the smallest version I could: three agents, one small coding task, and a live view of them working.

# The question behind it
The question the pattern actually answers is simple: how do you stop an agent from deciding its own work is good enough? Left alone, a model that writes code and then checks its own code tends to agree with itself. Gauntlet Loop's answer is to never let one agent do both — a builder writes, a separate critic judges, and the critic isn't allowed to just have an opinion. It has to check against something real.

# The pattern, in three rules
Stripped of the branding, it comes down to three things:
* **A concrete target, not "make it good".** The original version judged against real screenshots from an existing game. Anything vaguer than a real reference gives the critic nothing solid to check against.
* **The lead agent decides how to split the work**, not you upfront. It's the one that understands the task, so it decides what runs separately, together, or in parallel.
* **No self-grading.** Builder and critic are separate subagents. The loop repeats until the critic passes it — not until the builder feels done.

Worth saying plainly: this isn't a wildly new idea. It's generator-critic with a reference benchmark, and other people arrived at basically the same pattern under a different name around the same time. The part actually worth stealing isn't the name — it's forcing every task to have a real, checkable target instead of "looks fine to me."

# The demo, dressed as a kitchen
Instead of abstract "Lead / Builder / Critic" agents with a separate explanation on top, I gave the three roles their actual identity: **Küchenchef** (head chef), **Koch** (cook), **Verkoster** (taster). The simulation *is* the agent structure — no translation layer needed to understand who does what.

The task: `skaliere_rezept` — scale a recipe's ingredient list from one portion count to another. Picked on purpose, not at random: proper rounding to one decimal place needs commercial rounding (0.25 → 0.3), while Python's built-in `round()` sometimes rounds `.x5` values *down* instead (so-called banker's rounding). That's a real, common bug — not a contrived one — and it reliably produces a first rejection before the loop converges.

```python
# reference/task.md, rule 2
# Ergebnis auf eine Nachkommastelle kaufmännisch runden
# (0.25 -> 0.3, nicht 0.2 - Pythons round() reicht hier nicht)
```

The final accepted solution ended up using exactly that fix:

```python
from decimal import Decimal, ROUND_HALF_UP

neue_menge = Decimal(str(menge)) * portionen_neu / portionen_alt
gerundet = neue_menge.quantize(Decimal("0.1"), rounding=ROUND_HALF_UP)
```

# The one rule that keeps it honest
Each of the three agents has a narrow job and, more importantly, a narrow view:

* **Küchenchef** (model: opus) reads the recipe card, hands it to Koch, and relays Verkoster's verdict back. It has no Bash or Edit tools at all — it *can't* check anything itself, which closes the obvious loophole where the orchestrator quietly grades the work to save a round trip.
* **Koch** (model: sonnet) writes `build/solution.py` from the recipe card. It never sees the test file — it cooks from the recipe, not from the hidden checklist.
* **Verkoster** (model: haiku) never runs on vibes. Its default stance is reject; the only thing that changes its mind is running `uv run pytest reference/test_skaliere_rezept.py -v` and getting a clean pass.

The one rule written down explicitly, because it's the one that actually matters: Küchenchef forwards Verkoster's literal criticism back to Koch — but never forwards Koch's own explanation to Verkoster. If the critic ever saw the builder's reasoning, "I fused these two loops for performance" could talk it out of a real bug. Blind judging only works if it stays blind.

The three different models aren't arbitrary either: the heaviest reasoning (opus) goes to the one step that requires judgment — deciding what to do next — while the mechanical, rule-following step (running a fixed pytest command and reporting pass/fail) runs on the cheapest, fastest model.

# Watching it happen live
Every agent appends one line of JSON to `build/kitchen-events.jsonl` after each step — `{"actor": "koch", "status": "serviert", "text": "..."}` and similar. A small Python script serves that file over Server-Sent Events, using nothing but the standard library:

```python
server = http.server.ThreadingHTTPServer(("127.0.0.1", PORT), Handler)
```

`kitchen.html` is plain HTML/CSS/JS — no framework — that opens `new EventSource('/events')` and moves a "plate" between three station boxes as events come in, with a running feed underneath. Nothing about the pattern needs a live view to work; it's there because watching three agents actually argue over a rounding bug in real time is a much better way to understand the loop than reading a transcript afterward.

# Does it actually hold up?
The honest caveat, worth keeping: this only proves what it's told to check. Verkoster trusts one pytest file — if that file has gaps, a wrong solution can still pass. The independent step that actually matters is running the same test yourself afterward, outside the loop, and that's exactly what confirms whether the loop's own "PASS" was telling the truth or just consistent with what it was told to check.

That's really the whole idea in one sentence: an agent grading itself is worth very little, but an agent judged by a fixed, external, blind test — the same kind of test a human reviewer would run — is worth trusting a bit more.
