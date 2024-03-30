+++
title = "Programming Languages: Fundamentals"
date = 2020-02-09
+++

Table of contents:
* [Rust: fundamentals](#rust-fundamentals)
* [Go: fundamentals](#go-fundamentals)
* [Kotlin: fundamentals](#kotlin-fundamentals)
* [C++: Dynamic Memory Allocation](#cpp-dynamic-memory-allocation)

# Rust-Fundamentals
2021-03-07

## About
This document gives an overview about the programming language rust. Especially the wording, the syntax. If you come from a different programming language then you may need a kind of mind mapping.

> Learn Rust from my perspective.

## Cargo
_cargo_ is the build system and package manager. Dependencies will be automatically downloaded.

A cargo project is defined by a `cargo.toml` file.

The command for building a cargo project
```bash
cargo build
```

To run a cargo project
```bash
cargo run
```

## Crates
_crates_ are _libraries_

## Memory Management
Rust manages memory with __ownership__ system. While some languages clean up unused memory automatically (__gargabe collector__) or require programmers (__allocate__ and __free__) to do it.
Each value has an owner and you can borrow it.

## Modules
_modules_ are used for code organizing

## Attributes
_attributes_ are _annotations_

## Trait
> A `trait` is a collection of methods defined for an unknown type: `Self`

So in other words then the official description. A `trait` is a __`interface`__ in java language.

## Struct
We know the data type `struct` from C language. Rust provides in addition two more struct types: tuples and unit structs.
There is no class type in Rust. In Go language we also don't have class types.

## Method
You defined a structure but also want to add methods. Then you can use the `impl` keyword.

```rust
struct Developer {
    exp: u8
}

impl Developer {
    fn isExpert(&self) -> bool {
        self.exp > 100
    }
}
```

## String
Text can stored in rust in two ways.

The first way is to use the 'String' type. Which is a struct data type defined in rust std library: `Struct std::string::String`. The `String` is stored as a vector of bytes `Vec<u8>`.

And there is also a second string data type: `&str`.

## Slice
A slice is a two word object. The first word is a pointer to the data. The second word is the length of the slice.

> pointer size is usize (pointer size). `usize` is determined by the processor architecture. e.g. on `x86-64` the usize is __64 bit__.

A quick refresher regarding _word_:
```txt
8 bit = 1 byte
2 byte = 1 word
1 dword (double word) = 2 word
```

## Streams
Rust has in-build support for working with streaming or functional programming or collection tranformation operations.

A basic example. We have a vector of numbers and want to display that data as a reversed string. First we need a iterator [`iter()`]. Afterwards we can begin our data transformation.

```rust
let data = vec![0, 1, 1, 1];
let s: String = data.iter().map(|d| d.to_string()).rev().collect();

// output: 1110
```

> You may ask what is `vec!`. It's a macro, an alias to create new `Vec` and initialize with values.

## Sources
* https://doc.rust-lang.org/rust-by-example/
* https://mkaz.blog/working-with-rust/
* Android and Rust AOSP: https://source.android.com/setup/build/rust/building-rust-modules/overview

---

# Go-Fundamentals
2021-03-07

Go has no class types. Instead you can use `struct`.

```Go
type Developer struct {
	experience int
}
```

If you want to add a method to a class then you can define a function with a _receiver_ argument.
```Go
func (d Developer) Display() void {}
```

# Links
* https://tour.golang.org/methods/1

---

# Kotlin-Fundamentals
2021-03-07

## About
This document gives an overview of Kotlin programming languages characteristic components.

Kotlin is a __statically__ typed programming language like Java, C++, etc. Means that type of a variable is known at __compile time__. Whereas __dynamically__ typed programming languages like Python, JavaScript variable types are known at __runtime__.

When you write Kotlin code `.kt` the __Kotlin compiler__ creates a `.class` file. The compiler and the final application need the __Kotlin runtime library__.

## Why use Kotlin? 
Java development speed increased in latest years.

But currently there are still 3rd party libraries like lombok that developers prefer to get rid of boilerplate code. This brings new dependency and issues for later maintanence difficulities. Kotlin can also interact with Lombok generated code since 1.5.20.

Instead of using 3rd party libraries a developer may switch to kotlin. The interoperability with java code works well. In some edge-case it may have difficulities. But instead of introduce a new 3rd party the developer should use either java features only or introduce kotlin to an existing project.

A good example in the described example are `data class` in kotlin. In Java there will come a new feature `record`  (see link [1]). With Lombok you can achieve same result as a data class.

## Enum
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

## Sealed class
As the name __sealed__ suggest a `sealed class` is restricted. Restricted means subclasses are only allowed at compile-time. A sealed class is also __abstract__. 

A Sealed class can more then an enum class.

## by lazy
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

## lateinit
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

## Collections

Pair
```kt
println("# collections: pair")

val j = Pair("java", 11)
log("first: ${j.first}; second: ${j.second}")

// with _syntactic sugar_
val k = "kotlin" to 1.4
log("first: ${k.first}; second: ${k.second}")
```

Triple
```kt
val green = Triple(0, 255, 0)
log("rgb: ${green.first}, ${green.second}, ${green.third}")
```

Array
```kt
val i = intArrayOf(0, 10, 200)
val n = arrayOfNulls<Int>(3)
```

List
```kt
val n = listOf(0, 1, 2, 3, 3);
```

Map
```kt
val stack = mutableMapOf<Int, String>(10 to "python", 11 to "rust")
```

Set
```kt
val binary = setOf(0, 1, 1, 1)
```

## Links
* [0] https://kotlinlang.org/docs/sealed-classes.html
* [1] https://openjdk.java.net/jeps/359

---

# Cpp-Dynamic-Memory-Allocation
2020-02-09

* new and delete operators
* Dynamic Memory Allocation
* segmentation fault demo
* malloc() or calloc(), free()
* Memory Management

```cpp
#include <iostream>

using namespace std;

int main() {
    float* p;
    p = new float(3.14);
    cout << "\nnew example: " << *p;

    int size = 8;
    int* a = new int[size];
    cout << "\narray: " << *a;
    *a = 100;
    *a++;
    *a = 200;
    *a--;
    cout << "\narray: " << *a;
    cout << "\narray: " << a[1] << endl;

    delete [] a;
    cout << "\nprocessing finished: " << a[0] << endl;

    cout << "\nprocessing finished: " << endl;
    cout << "\nsegmentation fault: " << a[100] << endl;
}
```
