+++
title = "Android: RecyclerView"
date = 2020-02-26
+++

In order to use `RecyclerView` you need to setup following pieces:
* item: our data
* adapter: converts data/item to `RecyclerView`'s format. Check also code comment.
* viewholders: pool of reuse views
* recyclerview: `RecyclerView` interacts with `ViewHolder`

### Now we implement our logic
* create class `Datasource`: as the name suggests the data provider
* create data class `ProgrammingLang`: our entity

### Transform model to android
Next we need a way to take the data from data source and format it to `RecyclerView`'s format
The transformation is done with Adapters.
> Adapter is a __design pattern__ that adapts the data into something that understands `RecyclerView` 

### Example App
* check out the example app here: https://github.com/leventarican/android-kotlin-developer-ng/tree/main/examples/AppLe
