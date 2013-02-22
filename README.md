VertxGo
===============

VertxGo (aka 'Vertigo' or 'Vert.x Go!') is a CRUD Scaffolding Vert.x Module. Just provide a model in JSON, launch the mod and a complete Vertx CRUD (Create Read Update Delete) application will be created and ready to be deployed ! 

## Quickstart
* Create a new folder, i.e :

```
mkdir Todo
```

* Inside this folder, create a folder `mods` :

```
cd Todo
mkdir mods
```

* Copy the VertxGo module inside the `mods` folder (you can do it by cloning the repo)
Now we have to provide a model, the convention is that the model resides in a folder  ```model``` and named `model.json`, i.e `Todo/model/model.json` :

```
{"Task":
	{
	 "description":"string" 
	}
}
```
* Ok ! It's time to scaffold ! Run the mod : 
```vertx runmod vertxgo```

* You are done ! Make sure you have a ```MongoDb``` instance running and run your App
``` vertx run app.js```

* Browse to ``localhost:8080``
![task list](http://s11.postimage.org/5cqyn4r4z/task.png "task list")
* You can create, update and delete tasks 

## Under the hood

This module has been inspired by the vert.x official [Tutorial](http://vertx.io/js_web_tutorial.html). The generated app is based on ```BackBone``` and ```Twitter Bootstrap```.
In the future, it will also be possible to switch to ```angular``` templates.

The module itself has been written in ```Groovy``` and uses Groovy's ```SimpleTemplateEngine```. 

## Limitations
This is a very first version and comes with a lot of limitations (but enough features to impress your friends) : 

- Limited to one entity 
- Support only text input widgets (only String is supported)

## Features to come
- New input types (Date,Select,Radio ...)
- Multiple entities
- one-to-one relations
- one-to-many relations
- security scaffolding



