+++
title = "Rust Fundamentals"
date = 2021-03-07
+++

# About 
This document gives an overview about the programming language rust. Especially the wording, the syntax. If you come from a different programming language then you may need a kind of mind mapping.

# Trait
> A `trait` is a collection of methods defined for an unknown type: `Self`

So in other words then the official description. A `trait` is a __`interface`__ in java language.

# Struct
We know the data type `struct` from C language. Rust provides in addition two more struct types: tuples and unit structs.

# Method
You defined a structure but also want to add methods. Then you can use the `impl` keyword.

```
struct Developer {
    exp: u8
}

impl Developer {
    fn isExpert(&self) -> bool {
        self.exp > 30
    }
}
```

# Links
* https://doc.rust-lang.org/rust-by-example/trait.html
* https://doc.rust-lang.org/rust-by-example/custom_types/structs.html
* https://doc.rust-lang.org/rust-by-example/fn/methods.html
