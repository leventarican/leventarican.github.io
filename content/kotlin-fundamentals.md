+++
title = "Rust Fundamentals"
date = 2021-03-07
+++

# About
This document gives an overview of Kotlin programming languages characteristic components.

# Enum
An Enumartion data type is in Kotlin a class. It defined by `enum class`. Similar to `sealed class`.

Example: we define three constants. Whereas each constant is an object of the defined enum class.
```
enum class Developer {
    JUNIOR, SENIOR, EXPERT
}
```
Lets continue the example and give the option to assign an experience value. Each enum (e.g. `EXPERT`) is an instance of the defined enum class and initialized with the given `experience` value.
```
enum class Developer(val experience: Int) {
    JUNIOR(1), SENIOR(10), EXPERT(100)
}
```

# Sealed class
As the name __sealed__ suggest a `sealed class` is restricted. Restricted means subclasses are only allowed at compile-time. A sealed class is also __abstract__. 

A Sealed class can more then an enum class.


# Links
* https://kotlinlang.org/docs/sealed-classes.html
