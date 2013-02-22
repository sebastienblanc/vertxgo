import groovy.text.SimpleTemplateEngine
import groovy.json.JsonSlurper

def log = container.logger

//copy static resources
def config = container.config
def vertxgoLocation
if(config.vertxgoLocation){
	vertxgoLocation = config.vertxgoLocation
}
else {
	vertxgoLocation = "mods/org.aerogear.vertxgo-v0.1"
}

vertx.fileSystem.copy(vertxgoLocation+"/resources", "web",true) { ar ->
    if (ar.succeeded()) {
        log.info("Copy was successful")
    } else {
        log.error("Failed to copy", ar.exception)
    }
}

vertx.fileSystem.copy(vertxgoLocation+"/modz", "mods",true) { ar ->
    if (ar.succeeded()) {
        log.info("Copy was successful")
    } else {
        log.error("Failed to copy", ar.exception)
    }
}

vertx.fileSystem.copy(vertxgoLocation+"/app.js", "app.js",true) { ar ->
    if (ar.succeeded()) {
        log.info("Copy was successful")
    } else {
        log.error("Failed to copy", ar.exception)
    }
}

//first slurp the mode
def model = new FileReader('model/model.json')
JsonSlurper jsonSlurper = new JsonSlurper();
def result = jsonSlurper.parse(model);

//templating utlities
def renderer = {String key,String value->
	return  """
<label for="$key">$key</label>
<input type="text" id="$key" class="span2" data-bind="value: $key"/>
			"""
}

def rendererTd = {String key,String value->
	return  """
<td><input type="text" id="$key" class="span2" data-bind="value: $key"/></td>
     		"""	
}

def collectionRenderer = {String entity->
	return "${entity.toLowerCase()}s"
}

//set up the templating engine
def engine = new SimpleTemplateEngine()
def binding = ["entity":result.entrySet().first().key,"propertiez":result.entrySet().first().value,renderer:renderer,rendererTd:rendererTd,collectionRenderer:collectionRenderer,"dollar":"\$"]

//write the files
vertx.fileSystem.readFile(vertxgoLocation+"/templates/client_app.tpl"){ ar ->
	def clientTemplate = engine.createTemplate(ar.result.toString()).make(binding)	
	vertx.fileSystem.writeFile("web/js/client_app.js",clientTemplate.toString()) { clientResult ->
		 if (clientResult.succeeded()) {
        	log.info("Copy was successful")
	    } else {
	        log.error("Failed to copy", clientResult.exception)
	    }
	}
}

vertx.fileSystem.readFile(vertxgoLocation+"/templates/index.tpl"){ ar ->
	def indexTemplate = engine.createTemplate(ar.result.toString()).make(binding)
	vertx.fileSystem.writeFile("web/index.html",indexTemplate.toString()) { indexResult ->
		 if (indexResult.succeeded()) {
        	log.info("Copy was successful")
	    } else {
	        log.error("Failed to copy", indexResult.exception)
	    }
	}	
}

container.exit()
