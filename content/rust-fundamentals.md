+++
title = "Rust Fundamentals"
date = 2021-03-07
+++

# About
This document gives an overview about the programming language rust. Especially the wording, the syntax. If you come from a different programming language then you may need a kind of mind mapping.

> Learn Rust from my perspective.

# Cargo
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

# Crates
_crates_ are _libraries_

# Memory Management
Rust manages memory with __ownership__ system. While some languages clean up unused memory automatically (__gargabe collector__) or require programmers (__allocate__ and __free__) to do it.
Each value has an owner and you can borrow it.

# Modules
_modules_ are used for code organizing

# Attributes
_attributes_ are _annotations_

# Trait
> A `trait` is a collection of methods defined for an unknown type: `Self`

So in other words then the official description. A `trait` is a __`interface`__ in java language.

# Struct
We know the data type `struct` from C language. Rust provides in addition two more struct types: tuples and unit structs.
There is no class type in Rust. In Go language we also don't have class types.

# Method
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

# String
Text can stored in rust in two ways.

The first way is to use the 'String' type. Which is a struct data type defined in rust std library: `Struct std::string::String`. The `String` is stored as a vector of bytes `Vec<u8>`.

And there is also a second string data type: `&str`.

# Slice
A slice is a two word object. The first word is a pointer to the data. The second word is the length of the slice.

> pointer size is usize (pointer size). `usize` is determined by the processor architecture. e.g. on `x86-64` the usize is __64 bit__.

A quick refresher regarding _word_:
```txt
8 bit = 1 byte
2 byte = 1 word
1 dword (double word) = 2 word
```

# Streams
Rust has in-build support for working with streaming or functional programming or collection tranformation operations.

A basic example. We have a vector of numbers and want to display that data as a reversed string. First we need a iterator [`iter()`]. Afterwards we can begin our data transformation.

```rust
let data = vec![0, 1, 1, 1];
let s: String = data.iter().map(|d| d.to_string()).rev().collect();

// output: 1110
```

> You may ask what is `vec!`. It's a macro, an alias to create new `Vec` and initialize with values.

# Sources
* https://doc.rust-lang.org/rust-by-example/
* https://mkaz.blog/working-with-rust/
* Android and Rust AOSP: https://source.android.com/setup/build/rust/building-rust-modules/overview
