<!--
  ~ Copyright 2011-2012 the original author or authors.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~     http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  -->

<html>
<head>
  <link rel="stylesheet/less" href="css/bootstrap.less">
  <script src="js3rdparty/less-1.2.1.min.js"></script>
  <script src='js3rdparty/jquery-1.7.1.min.js'></script>
  <script src='js3rdparty/bootstrap-tabs.js'></script>
  <title>VertxGo! vertx scaffolding tool</title>
</head>

<body>

<div class="container-fluid">

  <div class="sidebar">
   
  </div>

  <div class="content">

    <div class="hero-unit">
      <h1>${entity} list</h1>
   </div>

    <div class="row">

    

      <div class="pill-content">

        <div class="active" id="shop">

          <div class="span16">

            <form class="form-stacked">
            <% propertiez.each{key, value -> print renderer(key,value)}%>
            <input type="submit" class="btn primary" value="Add ${entity}"
                     data-bind="click: create${entity}"/>
            </form>

            <table class="bordered-table">
              <thead>
              <tr>
                 <% propertiez.each{key, value ->%> 
                <th>$key</th>
                <%}%>
                <th>Update</th>
                <th>Delete</th>
              </tr>
              </thead>
              <tbody data-bind="foreach: ${collectionRenderer(entity)}">
              <tr>
                <% propertiez.each{key, value -> print rendererTd(key,value)}%>
                <td><a href="#" data-bind="click: ${dollar}root.update${entity}">Update ${entity}</a></td>
                <td><a href="#" data-bind="click: ${dollar}root.delete${entity}">Delete ${entity}</a></td>
              </tr>
              </tbody>
            </table>
          </div>

        </div>

      </div>

    </div>
  </div>
</div>

</body>


<script src='js3rdparty/sockjs-0.2.1.min.js'></script>
<script src='js3rdparty/knockout-2.0.0.js'></script>
<script src='js/vertxbus.js'></script>
<script src='js/client_app.js'></script>

</html>