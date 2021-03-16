+++
title = "Android: Architecture"
date = 2021-03-15
+++

# About
Give an overview about the Android Architecture components or bluebrints.

# Introduction
> There are different ways to develop an app. But the challenge is to develop an app with a good architecture.

By time Android development evolved to make development more comfortable e.g. skip writing boilerplate code.
Make code structure more _robust, testable, maintainable_.

At begin there was mainly an `Activity` component which represents a screen. Then `Fragments` where introduced. A type of micro-UI within an `Activty`.
Latetely an _android support library_ was introduced. With Android 9.0 this support library is called _AndroidX_.
_AndroidX_ is part of the _Jetpack_ library suite.

There are also 3rd party libraries which are commonly used.

Also important to mention is the usage of kotlin language extensions or features.

You also should know some different development approaches. E.g. _single-activity-architecture_.

> These additional components help you to improve your code quality but bring a lot of new dependencies. First you need too know and then use it suitable.

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

Some words about _Jetpack_. As already introduced it was formerly _Android Support Library_: v4 Support Libraries, v7 Support Libraries.
The _AndroidX library_ contains the existing support library and also includes the latest Jetpack components. 

### DataBinding
With data binding we can access the UI element directly over the generate Binding class. Instead of searching the hole UI tree `findviewbyId` we just access the view defined in the layout file directly.

```
binding.textView.text = 'kotlin'
```

> Too get such an `binding` object there are some prerequirements you need to too. E.g. include the dependency, wrap layout file with `<layout/>` tag and inflate the layout file.

### ViewModel
The view model component was introduced to hold the app data model in a lifecycle aware state. Whenever the `Acvitity` or `Fragment` lifecycle changes we need to care about the data state. With `ViewModel` this manual process is obsolete. The `ViewModel` manages the data for the UI. Either a single UI component (activity/fragment) or shared UI components.

> For a `ViewModel` integration we need to add dependencies, introduce a `ViewModel` class and get the `ViewModel` reference from a view model provider.

Now some code.
```
class DeveloperViewModel : ViewModel {}
```
In your UI component get the instance.
```

```

### LiveData
With `LiveData` for example we can do _reactive programming_. The UI react to changes on data.

```
data.payload.observe(this, {
    Log.d("#", "event received: $it. react...")
})
```

> `LiveData` is a _observable_ component and follows the _observer pattern_. It's usually used in combination with `ViewModel`. Where a `ViewModel` holds data as `LiveData`.

# 3rd Party
* Test: espresso, mockito
* REST API communitcation: Retrofit
* image loading: Glide
* logging: Timber

# Kotlin
Where does kotlin helps us the develop better apps. Like `Coroutines`. 

_Android KTX_ is a set of Kotlin extensions which is part of Android Jetpack.

# Links
* https://developer.android.com/jetpack
* https://developer.android.com/topic/libraries/support-library/index.html
* https://developer.android.com/topic/libraries/architecture

# Links: Github 
* https://github.com/android/architecture-components-samples/tree/master/GithubBrowserSample
* https://github.com/android/architecture-samples
* https://github.com/android/architecture-samples/wiki/To-do-app-specification
