+++
title = "Android: Wear OS"
date = 2023-06-25
+++

If you have a Samsung Watch 4 you are forced to use a Android smartphone together. There is even no option to add contact on watch without phone neither add a google account on watch.

Now what if you have a cellular (LTE) watch 4 and you want to use the watch independently / __standalone__ ?

# The Reset

Note, that you might for the _esim_ initially setup the watch with a smartphone. 

Afterwards you can do a reset of the watch: `settings > general > reset`, uncheck the esim delete option. So your esim is still linked with watch but everything else is reseted.

Now you are ready to start __hidden__ configuration by tapping `3x` on the blue icon, followed by `1 long tab`.

The watch will start without smartphone.

In this state you can dial calls. And also the health features should work. But google playstore etc. won't work as you can't add account without smartphone.

# The Developer

As the features are restricted in this standalone state luckily there is a way for developers.

In watch 4 you can activate the __hidden__ developer mode: `settings > info ... > softwareinfo`. Now tab `7x` on `softwareversion` and a message will appear that dev mod is on. Go back in menu and the dev mode item should visible.

As the dev mode is on you can install `apk`'s. As the watch 4 has no USB port we will connect via wifi. After that, we are ready to develop apps with Android Studio. The steps:
* connect to WLAN on watch 4
* on android studio open `device manager` > select tab `physical` > then `pair using wifi` > then tab `pair using pair code`
* on watch 4: `dev mode` > `wireless debugging` > `pair new devices` > use the `pin` to pair watch 4 with android studio

The app development in android studio is from now on quit straight forward. Just create a new project for wear ideally an empty compose activity. The select your device and run.

Here is a code snippet for start dialer intent.
```kotlin
@Composable
fun Greeting(greetingName: String, activity: ComponentActivity) {
    Text(
        modifier = Modifier.fillMaxWidth(),
        textAlign = TextAlign.Center,
        color = MaterialTheme.colors.primary,
        text = stringResource(R.string.hello_world, greetingName)
    )
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.Center
    ) {
        Button(onClick = { dialPhoneNumber("00001111", activity) }) {
            Text(text = "android")
        }
    }
}

fun dialPhoneNumber(phoneNumber: String, activity: ComponentActivity) {
    val intent = Intent(Intent.ACTION_DIAL).apply {
        data = Uri.parse("tel:$phoneNumber")
    }
    if (intent.resolveActivity(activity.packageManager) != null) {
        activity.startActivity(intent)
    }
}
```

For sure you also need the respective permission in your android manifest.

```xml
<uses-permission android:name="android.permission.CALL_PHONE"/>
```

# System environment
* Android studio Dolphin 2021.3.1 Patch 1
* Samsung SM-R865F, API Level 30, Android 11
