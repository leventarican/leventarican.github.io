+++
title = "Kotlin Fundamentals"
date = 2021-03-07
+++

# About
This document gives an overview of Kotlin programming languages characteristic components.

# Enum
An Enumartion data type is in Kotlin a class. It defined by `enum class`. Similar to `sealed class`.

Example: we define three constants. Whereas each constant is an object of the defined enum class.
```kt
enum class Developer {
    JUNIOR, SENIOR, EXPERT
}
```
Lets continue the example and give the option to assign an experience value. Each enum (e.g. `EXPERT`) is an instance of the defined enum class and initialized with the given `experience` value.
```kt
enum class Developer(val experience: Int) {
    JUNIOR(1), SENIOR(10), EXPERT(100)
}
```

# Sealed class
As the name __sealed__ suggest a `sealed class` is restricted. Restricted means subclasses are only allowed at compile-time. A sealed class is also __abstract__. 

A Sealed class can more then an enum class.

# by lazy
`by lazy` follows the delegation pattern. In the following example a get operation will be delegated to the String and only computed on _first_ access.
```kt
val code: String by lazy {
	"kotlin"
}
```

When should we use `by lazy` property initialization?
A good case is if you have a heavy class which initialization is time-consuming. Wouldn't is be better if we create it when it's needed? Another benefit is you will always use the same instance once an instance is created.
```kt
class Developer {
	private val coffee: CoffeeGrinder by lazy {
		CofeeGrinder()
	}
}
```

# lateinit
With `lateinit` you also achieve a later initialization like `by lazy`. In in this case you define where it's initialized. 
`lateinit` is good if you want to prevent nullable variable.
```kt
val data: String? = null
```

Better use `lateinit`.
```kt
lateinit var data: String 
```

> If you have a nullable variable and want to ensure an alternative or default value you can use the `?:` aka Elvis operator.
```kt
val process = data?.payload ?: "default-payload" 
```

# Links
* https://kotlinlang.org/docs/sealed-classes.html
