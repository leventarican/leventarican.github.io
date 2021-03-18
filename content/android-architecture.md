+++
title = "Android: Architecture"
date = 2021-03-15
+++

# About
Give an overview about the Android Architecture components or blueprints.

# Introduction
> There are different ways to develop an app. But the challenge is to develop an app with a good architecture.

By time Android development evolved to make development more comfortable e.g. skip writing boilerplate code.
Make code structure more _robust, testable, maintainable_.

At begin there was mainly an `Activity` component which represents a screen. Then `Fragments` where introduced. A type of micro-UI within an `Activity`.
Latetely an _android support library_ was introduced. With Android 9.0 this support library is called _AndroidX_.
_AndroidX_ is part of the _Jetpack_ library suite.

There are also 3rd party libraries which are commonly used.

Also important to mention is the usage of kotlin language extensions or features. Namely _Android KTX_.

You also should know some different development approaches. E.g. _single-activity-architecture_.

> These additional components help you to improve your code quality but bring a lot of new dependencies. First you need too know and then use it suitable.

# Components
Now lets list the available components. We want to know when to use which components and what the motivation of it.
* DataBinding
* ViewBinding
* ViewModel
* LiveData
* Room

You will often read the components with the apprevation MVVM architecture: Model - View - ViewModel

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

> Data Binding Library supports the developer to bind the UI with the data.

In your UI component you can then set data to UI.
```
binding.textView.text = 'data'
```

You can even skip this intermediate step and set value directly in your layout file with _expression language_.
```
<TextView android:text="@{viewmodel.data}" />
```

> Too get such an `binding` object there are some prerequirements you need to too. E.g. include the dependency, wrap layout file with `<layout/>` tag and inflate the layout file.

So you wrapped your layout file with `<layout>` and now want to use your views directly in your UI components. You need the respective binding instance. To get such an instance all you need to do is inflate the layout with your code with the `DataBindingUtil`. Let see some code artefacts.
```
val binding: FragmentDevBinding = DataBindingUtil.inflate(inflater, R.layout.fragment_dev, container, false)
```
Within an `Activity` the way to get the binding is a bit different.
```
val binding = MainActivityBinding.inflate(getLayoutinflater())
```

> You may ask where do I get the `*Binding` class. This class will be automatically generated when you wrap your layout file with `<layout>` tag. Thats also the reason why need to inflate the layout file with the `DataBindinUtil`.

We can even rename the generate Binding class name. This is not obligatory just a additional information.
```
<data class="Binding" />
```

A note about the _lifecycle owner_. If you want to use Data Binding with `LiveData` then you need to set the lifecycle owner to your binding instance. This is needed to define the scope of the `LiveData` object. Check also the API doc.
> Sets the LifecycleOwner that should be used for observing changes of LiveData in this binding

A lifecycle owner is class with an Android lifecycle. Like `Activity` or `Fragment`.

### View Binding
A kind of subset of data binding. In view binding there is no such techniques like _binding expression_, _binding adapters_ or _two-way binding_.
It's a good alternative to eliminate `findViewById`. There is no `<layout>` tag required in layout file. 

So, how can I use view binding? In comparison to data binding its enough to set the view binding build features to true. The binding class for a layout file will be automatically generated. 

```
buildFeatures {
    viewBinding = true
}
```

You can even ignore generating a binding class .
```
tools:viewBindingIgnore="true"
```

Now in your UI component you inflate your layout file with the generated binding class to get a binding class instance.
```
binding = ActivityMainBinding.inflate(layoutInflater)
```

### ViewModel
The view model component was introduced to hold the app data model in a lifecycle aware state. Whenever the `Acvitity` or `Fragment` lifecycle changes we need to care about the data state. With `ViewModel` this manual process is obsolete. The `ViewModel` manages the data for the UI. Either a single UI component (activity/fragment) or shared UI components.

> For a `ViewModel` integration we need to add dependencies, introduce a `ViewModel` class and get the `ViewModel` reference from a view model provider.

Now some code.
```
class DeveloperViewModel : ViewModel {}
```
In your UI component get the ViewModel instance.
```
val viewModel = ViewModelProvider(this).get(DeveloperViewModel::class.java)
// use viewModel to observe live data: viewModel.data.observe { ... }
```

Thats all. But there is also a concise way with _Android KTX_.
```
val viewModel: DeveloperViewModel by activityViewModels()
```
Or in an Activity
```
val viewModel: DeveloperViewModel by viewModels()
```

What if you need dependencies in your ViewModel class? E.g. add a repository to your ViewModel.
Remember the ViewModel manages your data. And it make sense that a ViewModel has access to a repository layer.

> Quick Refresh: A _Repository_ is a data abstraction layer for local, network, in-memory data.

Define the ViewModel as you would usually do in OOP by using a constructor.
Then you need to define a factory class which extends from `ViewModelProvider.Factory`.
```
class DeveloperViewModel(private val r: DeveloperRepository) : ViewModel {}
class DeveloperViewModelFactory(private val r: DeveloperRepository) : ViewModelProvider.Factory {}
```
On instantiating you provide then this factory class to the `ViewModelProvider`. With _Android KTX_ even more concise.
```
val vm: DeveloperViewModel by viewModels {
    DeveloperViewModelFactory(repository)
}
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
> __Android KTX__ is a set of Kotlin extensions which is part of Android Jetpack.

Android KTX helps us the develop better apps. Better means in this context with the help of Kotlin features we are able to write concise and readable code. That's the motivation behind the KTX extentions.

Then there is __kotlin-android-extensions__ (also known as _Kotlin synthetics_). A gradle plugin from jetbrains. Which is already deprecated.
Whenever you see a code snippet with the following import then its `kotlin-android-extensions`.
```
import kotlinx.android.synthetic.main.activity_main.*
```
You should migrate to __view binding__.

# Links
* https://developer.android.com/jetpack
* https://developer.android.com/topic/libraries/support-library/index.html
* https://developer.android.com/topic/libraries/architecture
* https://android-developers.googleblog.com/2020/11/the-future-of-kotlin-android-extensions.html

# Links: Github
* https://github.com/android/architecture-components-samples/tree/master/GithubBrowserSample
* https://github.com/android/architecture-samples
* https://github.com/android/architecture-samples/wiki/To-do-app-specification
