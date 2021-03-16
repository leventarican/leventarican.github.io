+++
title = "Architecture"
date = 2021-03-07
+++

# About 
This document gives an overview about software design: architecture, pattern, paradigm.

You may read, heard a lot of these terms. Lets be a bit more precise.

When we talk about _Software Architecture_ we mean the software structure mainly in a complex software system. How to organize the code. Its the high-level building block. 

With _Design Pattern_ commonly the repeating problems can solved proven building blocks.

And _Programming Paradigm_ is the way of programming: functional, object oriented, imperativ, declarativ, reactive, ...

> To conclude, these terms, approaches or techniques are a kind of best practices in software engineering. 

But firstly you should focus on problem solving. If you are familliar enough with the techniques you should use it.

# Design Pattern

### Delegation Pattern
> Delegation is like inheritance done manually through object composition.

A class _has_ an object (composition) rather then _is a_ object (inheritance).

Kotlin has a kind of build-in support for _Delegation Pattern_ with the `by`-clause.

The Delegation Pattern is also known as __Proxy__ or __Adapter__ Pattern.

Code example: https://github.com/leventarican/cookbook/blob/master/kotlin/dojo/kata16.kt

# Architecture

### ECS
The Entity Component System paradigm. This architecture type is commonly used in game development. It can be used in data driven development (DDD). 
In ECS you have:
1. Entity: is just a pointer / id to component / data. 
2. Component: the data itself
3. System: transforms the data

To name some usage example. The game engine bevy uses the data-driven approach. Also Unity goes from OOP approach to ECS approach.

### Onion Architecture
TODO

### BCE
TODO

### DDD
The Data Driven Development paradigm.
TODO: Domain Driven Development.

### HDD
The Hype Driven Development paradigm.

# Links
* https://bevyengine.org/learn/book/getting-started/ecs/
* https://www.raywenderlich.com/7630142-entity-component-system-for-unity-getting-started
* https://stackoverflow.com/a/4243407
