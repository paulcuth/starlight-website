<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="../../docs-assets/ico/favicon.png">

    <title>Starlight - Lua to JavaScript translator</title>
    <link href="<%= page.theme_path %>/css/app.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body class="home">
    <header>
      <h1><a href="/">Starlight</a></h1>
    </header>
    {{content}}

    <% page:include(page.theme_path..'/_footer') %>
    <% page:include(page.theme_path..'/_analytics') %>
  </body>
</html>
