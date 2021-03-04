+++
title = "Android: Testing"
date = 2020-03-04
+++

# About
An overview about Testing in Android. The following topics are covered.
* Basic Testing
* Testing Repository, ViewModel, Fragments
* Testing Navigation, Coroutines, Room, Databinding

# Introduction 
When you create a new android project you get a default testing setup.
If you look at your project you will see three so called _source sets_.
`androidTest` and `test` contains your tests
```
$ tree -d -L 2 app/src/

app/src/
├── androidTest
│   └── java
├── main
│   ├── java
│   └── res
└── test
    └── java
```

The default dependencies defined in gradle are `junit` and `espresso` library

> You may noticed that the _test_ folder represents the _junit_ library. Where you test your code, classes in _main_ folder.

> For the android test dependency _espresso_ library is used.

As a quick refresher. How to run a test in android studio: open your `ExampleUnitTest` class > mark the method annotated with `@Test` > right click > Run ...

# Android Test
The android test folder contains test which run on the android system. Not like the junit test which run on the local machine JVM (default java behaviour). The android test are also called _instrumented test_ whereas junit test are called _local test_.

To run an android test works same way as junit. After running an android test you should see something like `androidx.test.runner.AndroidJUnitRunner`. Which is an indication of running an android test. 

# TDD
We have seen that android gives us the default (plus android test) environment to code in Test Driven Development methodology.

> TDD: write test first, run test first and then implement the feature

# Examples
* https://github.com/udacity/android-testing.git
