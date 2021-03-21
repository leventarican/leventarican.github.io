+++
title = "Go Fundamentals"
date = 2021-03-07
+++

Go has no class types. Instead you can use `struct`.

```Golang
type Developer struct {
	experience int
}
```

If you want to add a method to a class then you can define a function with a _receiver_ argument.
```Golang
func (d Developer) Display() void {}
```

# Links
* https://tour.golang.org/methods/1
