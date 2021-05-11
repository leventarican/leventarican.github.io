+++
title = "Android: Basics"
date = 2021-05-08
+++

# About
Give an overview about Android basics.

# Introduction

## Activity

The very basic Android component is the `Activity`. An `Activity` is a window as you know it from the desktop world. Where the user can interact with the application.

An `Activity` is mostly used as fullscreen window. You can use an `Activity` also as floating or embedded window.

You place your UI with the method `setContentView(View)`. For example if you defined your UI in your layout file and you want to use it in your activity.

```kotlin
@Override
public void onCreate(Bundle savedInstanceState) {
	setContentView(R.layout.your_layout);
}
```

With `setContentView(View)` we are _inflating_ the view to the activity.

What does inflating means?
In short: it's the process of adding a view to activity on runtime.
The layout xml is get parsed, then the view hierarchy is build, and finally added to the parent view to _render_ your view's (UI).

### Lifecycle
An activity has a __lifecycle__ where it has different __stages__. These stages are covered through six callbacks: `onCreate(), onStart(), ...`. The android system invokes the callbacks as an activity enters a new __state__.

On some circumstates the system can destroy an activity instance. And the state of the application is may lost. For that cases you can save the instance state with `onSaveInstanceState()` and `Bundle`.

```kotlin
override fun onSaveInstanceState(outState: Bundle?) {
	outState?.run {
		putInt(DATA, currentData)
	}

	super.onSaveInstanceState(outState)
}
```

To restore the activity UI state you can then use the saved instance state.
```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
	super.onCreate(savedInstanceState)onSaveInstanceState(outState)

	// skip boilerplate code
	currentData = getInt(DATA)
}
```


## View
A View is a atomic element (building block) in Android. A view can be a button, text, ... or a layout. There are many layout options in Android: Relative, Linear, Constraint, ...

> View is the base class for widgets, which are used to create interactive UI components (buttons, text fields, etc.)

Now you read __View, Widget, Layout__. Let's see the class hierachy. You can see that View is in package `android.view` and a button in package `android.widget`.
```
kotlin.Any
	android.view.View
		android.widget.TextView
			android.widget.Button
``` 

Similarly for a layout. A __ViewGroup__ is an invisible container that holds other Views or ViewGroups.
```
kotlin.Any
	android.view.View
		android.view.ViewGroup
			android.widget.LinearLayout
```

We can create view either by XML definition or programmatically.

```kotlin
@Override
public void onCreate(Bundle savedInstanceState) {
	val b = Button()
	val t = TextView()
	val l = RelativeLayout()
	l.add(b)
	setContentView(l)
}
```

Here we created a ViewGroup (contains multiple views).

# Links
* https://developer.android.com/reference/android/app/Activity
* https://developer.android.com/reference/android/view/View
* https://developer.android.com/guide/components/activities/activity-lifecycle
