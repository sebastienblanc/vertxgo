/*
 * Copyright 2011-2012 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

(function DemoViewModel() {

  var that = this;
  var eb = new vertx.EventBus(window.location.protocol + '//' + window.location.hostname + ':' + window.location.port + '/eventbus');
  eb.onopen = function() {
     eb.send('vertx.mongopersistor', {action: 'find', collection: '${collectionRenderer(entity)}', matcher: {} },
      function(reply) {
        if (reply.status === 'ok') {
          var itemArray = [];
          for (var i = 0; i < reply.results.length; i++) {
            itemArray[i] = new ${entity}(reply.results[i]);
          }
          that.${collectionRenderer(entity)} = ko.observableArray(itemArray);
          ko.applyBindings(that);
        } else {
          console.error('Failed to retrieve ${collectionRenderer(entity)} : ' + reply.message);
        }
      });
  };

  eb.onclose = function() {
    eb = null;
  };
  <% propertiez.each{key, value -> %>
  that.$key  = ko.observable('');
  <%}%>

  that.delete${entity} = function(${entity.toLowerCase()}) {
   var taskMsg = {
      action: "delete",
      collection: "${collectionRenderer(entity)}",
      matcher: {
        "_id":${entity.toLowerCase()}._id
      }
    }

    eb.send('vertx.mongopersistor', taskMsg, function(reply) {
      if (reply.status === 'ok') {
        that.${collectionRenderer(entity)}.remove(${entity.toLowerCase()});
      } else {
        console.error('Failed to delete ${entity.toLowerCase()}');
      }
    });
  };

  that.update${entity} = function(${entity.toLowerCase()}) {
   var taskMsg = {
      action: "update",
      collection: "${collectionRenderer(entity)}",
      criteria: {
        "_id":${entity.toLowerCase()}._id
      },
      objNew : {
        ${dollar}set: {
            <% propertiez.each{key, value -> %>$key: ${entity.toLowerCase()}.$key,\n            <%}%>
        }
     },
    }

    eb.send('vertx.mongopersistor', taskMsg, function(reply) {
      if (reply.status === 'ok') {
        console.log("${entity.toLowerCase()} updated: " + JSON.stringify(${entity.toLowerCase()}));
      } else {
        console.error('Failed to update ${entity.toLowerCase()}');
      }
    });
  };

  that.create${entity} = function() {
   var taskMsg = {
      action: "save",
      collection: "${collectionRenderer(entity)}",
      document: {
         <% propertiez.each{key, value -> %>$key: that.$key(),\n         <%}%>
      }
    }

    eb.send('vertx.mongopersistor', taskMsg, function(reply) {
      if (reply.status === 'ok') {
              
          eb.send('vertx.mongopersistor', {action: 'findone', collection: '${collectionRenderer(entity)}', matcher: {"_id":reply._id} },
            function(reply) {
              if (reply.status === 'ok') {
                that.${collectionRenderer(entity)}.push(new ${entity}(reply.result));
               } else {
                console.error('Failed to retrieve ${entity.toLowerCase()}: ' + reply.message);
              }
            });

      } else {
        console.error('Failed to create ${entity.toLowerCase()}');
      }
    });
  };

  

  function ${entity}(json) {
    var that = this;
    that._id = json._id;
    <% propertiez.each{key,value -> %>that.$key = json.$key;\n    <%}%>
  }

 
})();