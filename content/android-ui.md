+++
title = "Android: UI"
date = 2021-03-18
+++

# About
Give an overview about Android UI components. Know the naming of the components.

# App bar
The __app bar__ also known as the `ActionBar`. Later the `Toolbar` was introduced. The `ActionBar` as usually used in combination `Activity` whereas the `Toolbar` is more flexible.
An `Activity` in Android context is a window like in a desktop app. And a desktop app has usually a toolbar.

# Menu
There are different menu types: options menu (aka. _overflow_ menu), contextual menu and popup menu.

# Navigation
With navigation the movement (back and forth) from screen to screen is meant. Android provides two system provides UI components to navigate back on press. One option is the __back__ button in the __system navigation bar__. Second option is __up__ button in the __app bar__.

With Navigation UI you can tie navigation destinations with menu items. If you have an options menu and want to navigate to a specific screen then use the same id as the destination id. The `navigation-ui-ktx` component follows here the __convention-over-code__ principle.

In this menu definition we have an logout item. On click the screen should switch to login fragment.
```xml
<item android:id="@+id/loginFragment" android:title="Logout" />
```

In our _navigation graph_ file we defined the fragment with the same id `loginFragment`.
```xml
<fragment android:id="@+id/loginFragment" />
```

# Layout
Layout's in Android are a huge topic. By time the available layout's evolved. You should basically know to use which layout when. 
* Whats the difference `ConstraintLayout` to `CoordinatorLayout`. 
* `RecyclerView` is a good choice for large list items. 
* You should also know that are `<include>` and `<merge>` layout tags

# Links
* https://developer.android.com/training/appbar
* https://developer.android.com/guide/topics/ui/menus#options-menu
* https://developer.android.com/guide/navigation/navigation-principles
* https://developer.android.com/guide/navigation/navigation-ui#Tie-navdrawer
* https://developer.android.com/guide/navigation/navigation-ui#add_a_navigation_drawer
