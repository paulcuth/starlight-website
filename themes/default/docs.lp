<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../../docs-assets/ico/favicon.png">

    <title>Starlight - Lua to JavaScript translator :: <%= title %></title>
    <link href="<%= page.theme_path %>/css/app.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body class="docs">
    <div class="page-content">
      <div class="sidebar">
        <header>
          <h1><a href="/">Starlight</a></h1>
        </header>

        <nav>
          <ol>
            <li><a href="/docs/embedding-lua-in-the-web">Embedding Lua in the Web</a></li>
            <li><a href="/docs/interacting-with-javascript">Interacting with JavaScript</a></li>
            <li><a href="/docs/using-starlight-with-grunt">Using Starlight with Grunt</a></li>
          </ol>
          <ol>
            <li><a href="/download">Download</a></li>
            <li><a href="https://github.com/paulcuth/starlight-examples/">Examples</a></li>
            <li><a href="https://github.com/paulcuth/starlight/">GitHub</a></li>
            <li><a href="https://twitter.com/lua_to_es6/">Twitter</a></li>
          </ol>
        </nav>
      </div>

      <article>
        <div class="content">
          {{content}}
        </div>
      </article>
    </div>
    
    <% page:include(page.theme_path..'/_footer') %>
    <% page:include(page.theme_path..'/_analytics') %>
  </body>
</html>
