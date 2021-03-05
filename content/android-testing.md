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
If you look at your project you will see three so called __source sets__.
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
The android test folder contains test which run on the android system. Not like the junit test which run on the local machine JVM (default java behaviour). The android test are also called __instrumented test__ whereas junit test are called __local test__.

To run an android test works same way as junit. After running an android test you should see something like `androidx.test.runner.AndroidJUnitRunner`. Which is an indication of running an android test. 

# TDD
We have seen that android gives us the default (plus android test) environment to code in Test Driven Development methodology.

> TDD: write test first, run test first and then implement the feature

> The testing code is also a kind of a documentation _what your code does_.

# Good practices
Use good naming. Example: `subjectUnderTest_actionOrInput_resultState`.
Structure your test code using Given / When / Then.
```
@Test
fun getDeveloper_expert_returnsExpert() {
    // GIVEN
    val devs = listOf<Developers>(Developer(experience=10), Developer(experience=15), Developer(experience=30))
    // WHEN
    val result = getNumberOfSeniorDevelopers(devs)
    // THEN
    assertEquals(3, result)
}
```
Use an assertion framework. For example hamcrest framework. For hamcrest you need to add the dependency in your build file.
```
// `is` so called _matcher_
assertThat(result, `is`(3))
```

# Test scope aka. Testing Pyramid
On automated testing generally three test scopes are used:
* __Unit__ tests: scope is class, function
* __Integration__ tests: a combined test. Test how components work together. Ensure that a features works as expected.
* __End to end__ test: test the combination of features. In android context this is almost __instrumented__ testing.

Btw. you will also find other testing pyramid specification. But this three layer definition should enough for most purposes. 

Recommendation for coverage is: 
* Unit Tests: 70%
* Integration Tests: 20%
* E2E Tests: 10%
But my thoughts are the main __impact__ does the end to end tests.

A big issue is also if you have large function or othere components with lot of dependencies. 
It's difficult to test. You may can do a end to end test. But creating unit test could be in that case difficult.

That's why you should __break down__ your application logic into isolated components.
With a well defined (best practice) application architecture you can divide your code in a defined way.

![](../android-testing.png)

# Links
* https://github.com/udacity/android-testing.git
* https://developer.android.com/training/testing/fundamentals
