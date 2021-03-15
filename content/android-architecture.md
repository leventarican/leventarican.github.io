+++
title = "Android: Architecture"
date = 2020-03-15
+++

# About
Give an overview about the Android Architecture components.

# Introduction
> There are different ways to develop an app. But the challange is to develop an app with a good architecture.

By time Android development evolved to make development more comfortable e.g. skip writing boilerplate code.
Make code structure more _robust, testable, maintainable_.

At begin there was mainly an `Activity` component which represents a screen. Then `Fragments` where introduced. A type of micro-UI within an `Activty`.
Latetely an _android support library_ was introduced. With Android 9.0 this support library is called _AndroidX_.
_AndroidX_ is part of the _Jetpack_ library suite.

There are also 3rd party libraries which are commonly used.

Also important to mention is the usage of kotlin language extensions or feature.

You also should know some different development approaches. E.g. _single-activity-architecture_.

> There all additional components help you to improve your code quality but bring a lot of new dependencies. First you need too know and then use it suitable.

# Components
Now lets list the components available. We want to know when to use which components and what the motivation of it.
* DataBinding
* ViewBinding
* ViewModel
* LiveData
* Room

If we need to store or request/fetch data from a data source we can achieve this in different ways. You should know that read/write operation on _cache/memory/in-memory_ is different to _disc_ or even _network_. To summarize there are different data persistence layers.

| Type         | IO time   |
|--------------|-----------|
| cache/memory | fast      |
| disc         | slow      |
| network      | very slow |

When we develop an app our intention is mainly to receive input then display respective information. It's the usual data process: `input -> process -> output`. The components listed above are intended to support displaying, storing, ... data. We achieve a decopling of the code components.

# 3rd Party
* Test: espresso, mockito
* REST API communitcation: Retrofit
* image loading: Glide
* logging: Timber


# Kotlin
Where does kotlin helps us the develop better apps. Like `Coroutines`. 

# Links
* https://developer.android.com/jetpack
* https://developer.android.com/topic/libraries/support-library/index.html
* https://developer.android.com/topic/libraries/architecture

# Links: Github 
* https://github.com/android/architecture-components-samples/tree/master/GithubBrowserSample
* https://github.com/android/architecture-samples
* https://github.com/android/architecture-samples/wiki/To-do-app-specification
