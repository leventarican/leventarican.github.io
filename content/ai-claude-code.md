+++
title = "AI: Claude Code"
date = 2025-05-22
+++

# About
On May 22, Anthropic announced Claude 4. Alongside this, they also released a CLI tool called Claude Code. As I prefer interacting with computers via the terminal (shoutout to Ghostty), I was eager to try it out. For interacting with Claude models, I use the API. This document will record my impressions and experiences. Let's see how far I can go with just $5.

```

 ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
██║     ██║     ███████║██║   ██║██║  ██║█████╗  
██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  
╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
 ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
 
 ██████╗ ██████╗ ██████╗ ███████╗                
██╔════╝██╔═══██╗██╔══██╗██╔════╝                
██║     ██║   ██║██║  ██║█████╗                  
██║     ██║   ██║██║  ██║██╔══╝                  
╚██████╗╚██████╔╝██████╔╝███████╗
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝

```
# Usage 
```bash
claude --version
1.0.0 (Claude Code)
```

OK we are now ready to interact so let's start. Create a new empty folder change to it and ...
```bash
claude
✻ Welcome to Claude Code!
```

My first prompt was to create a Tetris game using pure JavaScript in a single HTML file. This way, we can simply open the file and start playing. In less than a minute, Tetris was created and playable. ✔

# The Example

Now let's give another try and create an console app in pure js which get's a file and count the rows.

Input
> Create a single-file JavaScript console app that counts and prints the number of rows in a given text using an emoji and the row count.

Output 

```
● Created row-counter.js - a console app that counts text rows and displays them with 📊 emoji. Usage: node row-counter.js <filename> or pipe text to it.

> /cost
  ⎿  Total cost:            $0.0298
     Total duration (API):  31.7s
     Total duration (wall): 1m 10.3s
     Total code changes:    44 lines added, 0 lines removed
     Token usage by model:
         claude-3-5-haiku:  2.1k input, 150 output, 0 cache read, 0 cache write
            claude-sonnet:  19 input, 590 output, 41.9k cache read, 1.6k cache write
```


Test 

```bash
node row-counter.js row-counter.js
📊 44 rows
```

Conclusion

As you see the model create a file with 44 lines `44 lines added`. It cost ~ $0.02. Then we used the app to validate and we et here the same result `44 rows`. So we checked if app is running and if lines matches.

# The Cost
Every step you do interacts with the model. This good thing is. It seems that claude code decide which model is used. So for basic stuff `claude-3-5-haiku` is used. Which is cheaper compared to more advanced models.

You can check the cost for a session with a command. But even the cost command itself costs! 
``` 
> /cost
  ⎿  Total cost:            $0.1198
     Total duration (API):  42s
     Total duration (wall): 17m 34.8s
     Total code changes:    33 lines added, 0 lines removed
     Token usage by model:
         claude-3-5-haiku:  1.8k input, 145 output, 0 cache read, 0 cache write
            claude-sonnet:  40 input, 823 output, 118.9k cache read, 18.6k cache write
```

# Mtok 

We saw previously that every interaction with the model costs. So it makes sense in near future we will think more in __Mtok__.
Instead horse power _HS_ or computing power _Hertz_ we calculate using unity _Mtok_.

```
> /model 

Switch between Claude models. Applies to this session and future Claude Code sessions. For custom model names, specify with --model.
1. Default (recommended)  Use the default model (currently Claude Sonnet 4) · $3/$15 per Mtok
2. Opus                   Claude Opus 4 for complex tasks · $15/$75 per Mtok
```

# The End 
So my hole experience (incl. Tetris game creation, create CLAUDE.md, run commands) cost ~ 0.25$.
Now let's exit Claude Code with
``` bash 
:q
```

