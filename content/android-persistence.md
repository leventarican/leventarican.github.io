+++
title = "Android: Persistence"
date = 2021-03-28
+++

# About
This document aims to give a short introduction to Room persistence library.

# Introduction
A Room database is defined by the following components:
* SQLite
* DAO: data access object
* entity class: a data class with annotation (_metainformation_ for Room library)

An _entity_ represents a table in database. The interaction (insert, queries, ...) to database are represented by interfaces.
An interface define how to interact with a database. In Room it's the DAO

> DAO is a __design pattern__. The motivation is to abstract the database layer to switch the database technology behind the DAO.

Now lets see annotation examples. Here we have a pure data class.

```kotlin
data class Developer(
	var id: Long = 0L,
	var exp: Int = 10,
	var timestamp: Ĺong = System.currentTimeMillis()
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

# Links
https://developer.android.com/training/data-storage/room