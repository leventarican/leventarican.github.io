+++
title = "Architecture"
date = 2021-03-07
+++

# About 
This document gives an overview about software architecture, pattern, paradigm.

# ECS
The Entity Component System paradigm. This architecture type is commonly used in game development. It can be used in data driven development (DDD). 
In ECS you have:
1. Entity: is just a pointer / id to component / data. 
2. Component: the data itself
3. System: transforms the data

To name some usage example. The game engine bevy uses the data-driven approach. Also Unity goes from OOP approach to ECS approach.

# Links
* https://bevyengine.org/learn/book/getting-started/ecs/
* https://www.raywenderlich.com/7630142-entity-component-system-for-unity-getting-started
