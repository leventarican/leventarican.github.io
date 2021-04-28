+++
title = "Android: Persistence"
date = 2021-03-28
+++

# About
This document aims to give a short introduction to Room persistence library.

# Introduction
You want to store data on your local machine. And want to provide offline app user experience. Room library could be a choice for that.
Room helps us to create and use a local database. Room is Android's own implementation of ORM (object relational mapping).
There are also another ORM projects before Room exists.

A Room database is defined by the following components:
* SQLite
* DAO: data access object
* entity class: a data class with annotation (_metainformation_ for Room library)

An _entity_ represents a table in database. The interaction (query) to database are represented by interfaces.
An interface define how to interact with a database. In Room the interface is the DAO.

> DAO is a __design pattern__. The motivation is to abstract the database layer to switch the database technology behind the DAO. With a DAO class we map kotlin function to sql queries. Think of a DAO as defining a _custom interface_ for accessing your db.

> query: a request for data from a database (select) or a request to perform an action on the data (insert, delete)

Now lets see annotation examples. Here we have a pure data class.

```kotlin
data class Developer(
	var id: Long = 0L,
	var exp: Int = 10,
	var timestamp: Long = System.currentTimeMillis()
	)
```

In order to make it useable for Room we add annotations. We want a different table name and we want also that the system generate the id for us. 

```kotlin
@Enitity(tableName = "developer_table")
data class Developer(
	@PrimaryKey(autoGenerate = true)
	var id: Long = 0L,
	@ColumnInfo(name = "experience")
	var exp: Int = 10,
	var timestamp: Ĺong = System.currentTimeMillis()
	)
```
> note that by default the class name is used as table name. same for variable names.

Here is an example for an interface with Room. A DAO for interacting with the database.
```kotlin
@Dao
interface DeveloperDAO {
    @Insert
    fun insert(data: Developer)
}
```

Ok now described our tables and our interaction. Finally we define a database _abstract_ class which extends `RoomDatabase`. It's abstact because Room will do the implementation for us. 
```kotlin
@Database(entities = arrayOf(Developer::class), version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun developerDao(): DeveloperDao
}
```

A nice feature of Room is the support of `LiveData`. 
Example when you define your DAO interface and you query data you can specify the result as `LiveData`. Which mean you call the function __once__ and then can use the LiveData to __observe__ from it.

```kotlin
@Dao
interface DeveloperDAO {
    @Query
    fun getAll(): LiveData<List<Developer>>
}
```

## Main / UI Thread
Long running operation like database operations should run on a separate thread (_non-blocking_). That's why it is a good idea to run these operations with kotlin __coroutines__.

> __Recap__: the main thread (also called UI thread) is a single thread that handles all updates on UI. The main thread has to update the screen every _16ms_ or more or 60 fps to ensure everythings is smooth. Many tasks takes longer then 16ms such as fetch data from internet, reading a large file, database operations, etc.

Whenever using coroutines with Room you need to ensure that functions in the call-hierarchy are marked with `suspend` otherwise Room won't recognize it and it will still try to run it on main thread. 
You may then receive an error like this. Because Room will not allow access database without thread's by default.
```
Cannot access database on the main thread since it may potentially lock the UI for a long period of time.
```

Example:
```kotlin
fun init() {
	scope.launch { data = database.all() }
}

interface AppDatabaseDao {
	@Query("select * from data_table order by dataId desc")
	suspend fun all(): Data?
}
```

# Links
* https://developer.android.com/training/data-storage/room
* https://developer.android.com/jetpack/androidx/releases/room
