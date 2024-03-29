+++
title = "Kotlin Fundamentals"
date = 2021-03-07
+++

# About
This document gives an overview of Kotlin programming languages characteristic components.

Kotlin is a __statically__ typed programming language like Java, C++, etc. Means that type of a variable is known at __compile time__. Whereas __dynamically__ typed programming languages like Python, JavaScript variable types are known at __runtime__.

When you write Kotlin code `.kt` the __Kotlin compiler__ creates a `.class` file. The compiler and the final application need the __Kotlin runtime library__.

# Why use Kotlin? 
Java development speed increased in latest years.

But currently there are still 3rd party libraries like lombok that developers prefer to get rid of boilerplate code. This brings new dependency and issues for later maintanence difficulities. Kotlin can also interact with Lombok generated code since 1.5.20.

Instead of using 3rd party libraries a developer may switch to kotlin. The interoperability with java code works well. In some edge-case it may have difficulities. But instead of introduce a new 3rd party the developer should use either java features only or introduce kotlin to an existing project.

A good example in the described example are `data class` in kotlin. In Java there will come a new feature `record`  (see link [1]). With Lombok you can achieve same result as a data class.

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

# Collections

## Pair
```kt
println("# collections: pair")

val j = Pair("java", 11)
log("first: ${j.first}; second: ${j.second}")

// with _syntactic sugar_
val k = "kotlin" to 1.4
log("first: ${k.first}; second: ${k.second}")
```

## Triple
```kt
val green = Triple(0, 255, 0)
log("rgb: ${green.first}, ${green.second}, ${green.third}")
```

## Array
```kt
val i = intArrayOf(0, 10, 200)
val n = arrayOfNulls<Int>(3)
```

## List
```kt
val n = listOf(0, 1, 2, 3, 3);
```

## Map
```kt
val stack = mutableMapOf<Int, String>(10 to "python", 11 to "rust")
```

## Set
```kt
val binary = setOf(0, 1, 1, 1)
```

# Links
* [0] https://kotlinlang.org/docs/sealed-classes.html
* [1] https://openjdk.java.net/jeps/359
