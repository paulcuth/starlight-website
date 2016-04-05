<nav>
  <ul>
    <li><a href="/docs">Documentation</a></li>
    <li><a href="/download">Download</a></li>
    <li><a href="/examples">Examples</a></li>
    <li><a href="https://github.com/paulcuth/starlight">GitHub</a></li>
    <li><a href="https://twitter.com/lua_to_es6">Twitter</a></li>
  </ul>
</nav>

<article>
  <div class="content">
    <h3>Use Lua in <code>&lt;script&gt;</code> tags</h3>
    <p>Embed Lua code into your Web page, load remote Lua scripts, organise your code into modules and use JavaScript APIs and the DOM with ease. Starlight translates Lua to ES2015, find out more in the <a href="/docs">docs</a>.</p>
    
    <pre><code>&lt;script type="application/lua" src="./scripts/my-app.lua"&gt;&lt;/script&gt;</code></pre>

    <p>
      <a class="jsbin-embed" href="http://jsbin.com/fupiwe/embed?html,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>
    </p>
    <p class="buttons"><a class="button" href="/docs">Find out more</a></p>


    <h3>Package Lua in your front-end build scripts</h3>
    <p>Use the Grunt plugin to precompile all your Lua scripts to JavaScript. Find out more in the <a href="/docs/using-starlight-with-grunt">docs</a>.</p>
      <pre><code>grunt.loadNpmTasks('grunt-starlight');
grunt.initConfig({
  starlight: {
    'hello-world': {
      src: 'src/lua/hello-world.lua',
      dest: 'dist/js/hello-world.lua.js',
    },
  },
});</code></pre>
    </p>
    <p class="buttons"><a class="button" href="/docs/using-starlight-with-grunt">Find out more</a></p>


    <!-- h3>Sandbox your users' scripts</h3>
    <p>The Lua environment is sandboxed within Starlight so you can keep control of your page. Expose only the methods to want to your users.</p>
    <p>Configure the colour of this textbox with the <code>setHexColor()</code> method.</p>
    <p>
      <a class="jsbin-embed" href="http://jsbin.com/zeyiha/embed?html,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>
    </p>
    <p class="buttons"><a class="button href="/docs">Find out more</a></p -->

  </div>
</article>

