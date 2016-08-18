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
    <h3><pre>&lt;script type="<b>application/lua</b>"&gt;</pre></h3>
    <p>Embed Lua code into your Web page, load remote Lua scripts, organise your code into modules and use JavaScript APIs and the DOM in Lua with ease. Starlight translates Lua to ES2015, discover more in the <a href="/docs">docs</a>.</p>
    
    <figure>
      <pre><code class="html">&ltscript type="application/lua"&gt<b>
  for i = 1, 15 do
    local result = {}

    if i % 3 == 0 then
      table.insert(result, 'Fizz')
    end

    if i % 5 == 0 then
      table.insert(result, 'Buzz')
    end

    print(#result &gt 0 and table.concat(result) or i)
  end</b>
</b>&lt/script&gt</code></pre>
      <figcaption class="js-bin"><a href="http://jsbin.com/hodutafaju/1/edit?html,console">Run in JS Bin</a></figcaption>

      <pre><code class="console">1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz</code></pre>
    </figure>

    <p class="buttons"><a class="button" href="/docs">Find out more</a></p>


    <h3>Package Lua in your front-end build scripts</h3>
    <p>Use the <code>grunt-starlight</code> plugin to precompile all your Lua scripts to JavaScript. Discover more in the <a href="/docs/using-starlight-with-grunt">docs</a>.</p>

    <figure>
      <pre><code class="gruntfile">grunt.loadNpmTasks('grunt-starlight');
grunt.initConfig({
  starlight: {
    'hello-world': {
      src: 'src/lua/hello-world.lua',
      dest: 'dist/js/hello-world.lua.js',
    },
  },
});</code></pre>
    </figure>

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

