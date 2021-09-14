+++
title = "Android: UI"
date = 2021-03-18
+++

# About
Give an overview about Android UI components. Know the naming of the components.

# App bar
The __app bar__ also known as the __action bar__. Later the __toolbar__ was introduced. The `ActionBar` as usually used in combination `Activity` whereas the `Toolbar` is more flexible. You can place a toolbar at an arbitrary location in view hierarchy whereas an app bar is controled by the framework.

> Analogy: an Activity in Android context is like a window in a desktop app. And a desktop app has usually a toolbar.

# Menu
There are different menu types: options menu (aka. _overflow_ menu), contextual menu and popup menu.

# Navigation
With navigation the movement (back and forth) from screen to screen is meant. 
You can navigate between different Activies and between Fragments in an Activity.

Historically (or with basic Android building blocks) you implement navigate between the screens with intents and fragment transactions.

Whenever you navigate to a screen the previous screen is arranges in a stack which is called the __back stack__. It follows the stack principle _LIFO (last in, first out)_. You can go back but not forth when you hit the back button.
![](../backstack.png)

Difference between Activity back stack and Fragment back stack: when you navigate back in an Activity stack you can go back until leaving the App. Navigating within Fragments are similar but the stack boundaries are the Activity which hosts the Fragments (Fragment Manager, Transaction).

## Navigation Component
__Navigation Component__ is another way to navigate between the screens.
The Navigation component is a collection of libraries, plug-in and tooling.
It handles the back stack, fragment transactions, argument passing (safe args), deep linking, navigation-based animations. 

All the navigation information is centralized and visualised in the __Navigation graph__. Aside nav graph you should understand the role of __NavHost__ and __NavController__. The host component acts as the name suggests as a host of the current (or destination screen). The controller component on the other side _orchestrates_ the swapping of the screen within the host component (NavHost).

To be more concrete. An activity has the ability to display. Thas why it's obvious to define a _NavHost_ in an activity.

![](../nav-component.png)

Android provides two system UI components to navigate back on press. One option is the __back__ button in the __system navigation bar__. Second option is __up__ button in the __app bar__.

![](../android-bar.png)

### Navigation UI
With __Navigation UI__ you can tie navigation destinations with menu items. If you have an options menu and want to navigate to a specific screen then use the same id as the destination id. The `navigation-ui-ktx` component follows here the __convention-over-code__ principle.

In this menu definition we have an logout item. On click the screen should switch to login fragment.
```xml
<item android:id="@+id/loginFragment" android:title="Logout" />
```

In our _navigation graph_ file we defined the fragment with the same id `loginFragment`.
```xml
<fragment android:id="@+id/loginFragment" />
```

At this point (Navigation UI component) it make sense also to mention the __Drawer__ component. The navigation drawer shows the _navigation menu_. You can open it by selecting drawer icon or swipe from left edge.

![](../navigation-drawer.png)

### Safe Args
When navigating you may also want to pass data between the screens. Safe Args plugin generate also classes which can be used for navigation. E.g. you have defined screens (fragments) and connect the screen with actions. To apply the direction you can use the generated class.

```kotlin
val data = "data#payload"
val action = Screen0FragmentDirections.actionScreen0FragmentToScreen1Fragment(data)
findNavController().navigate(action)
```

To receive the data we use the arguments (variable) which is already given (generated) in our fragment.
```kotlin
val bundle = arguments
bundle?.let {
    val args = Screen1FragmentArgs.fromBundle(it)
}
```

In the code example above we use the defined action to change the screens (from screen0 to screen1). We also pass data (type string). Now before you can use this piece of code you need some pre-steps. Let's have look to the navigation file where we defined an `action` and an `argument`.

```xml
<!-- FOR THE SAKE OF SIMPLITY BOILERPLATE CODE IS NOT GIVEN -->
<fragment>
    <action
        android:id="@+id/action_screen0Fragment_to_screen1Fragment"
        app:destination="@id/screen1Fragment" />
</fragment>
<fragment>
    <argument
        android:name="data"
        app:argType="string"
        android:defaultValue="default-data" />
</fragment>
```

Safe args is optional so if you want to use it you also need to add the dependencies in your gradle file.
```groovy
// plugin apply in module gradle
id 'androidx.navigation.safeargs.kotlin'

// dependency in top-level gradle file
classpath "androidx.navigation:navigation-safe-args-gradle-plugin:2.3.4"
```

# Layout
Layout's in Android are a huge topic. By time the available layout's evolved. You should basically know to use which layout when. 
* Whats the difference `ConstraintLayout` to `CoordinatorLayout`. 
* `RecyclerView` is a good choice for large list items. 
* You should also heard about `<include>` and `<merge>` layout tags for performance improving and __reusing__ of layouts.

# Links
* https://developer.android.com/training/appbar
* https://developer.android.com/guide/topics/ui/menus#options-menu
* https://developer.android.com/guide/navigation/navigation-principles
* https://developer.android.com/guide/navigation/navigation-ui#Tie-navdrawer
* https://developer.android.com/guide/navigation/navigation-ui#add_a_navigation_drawer
* https://developer.android.com/training/improving-layouts/reusing-layouts
* https://developer.android.com/guide/navigation/navigation-getting-started