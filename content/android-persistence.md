+++
title = "Android: Persistence"
date = 2021-03-28
+++

# About
This document aims to give a short introduction to Room persistence library.

# Introduction
Room helps us to create and use a local database.
A Room database is defined by the following components:
* SQLite
* DAO: data access object
* entity class: a data class with annotation (_metainformation_ for Room library)

An _entity_ represents a table in database. The interaction (insert, delete, update, queries) to database are represented by interfaces.
An interface define how to interact with a database. In Room the interface is the DAO.

> DAO is a __design pattern__. The motivation is to abstract the database layer to switch the database technology behind the DAO. With a DAO class we map kotlin function to sql queries. Think of a DAO as defining a _custom interface_ for accessing your db.

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

Ok now described our tables and our interaction. Finally the creation of an database works 
```kotlin
@Database(entities = arrayOf(Developer::class), version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun developerDao(): DeveloperDao
}
```

# Links
* https://developer.android.com/training/data-storage/room
* https://developer.android.com/jetpack/androidx/releases/room
