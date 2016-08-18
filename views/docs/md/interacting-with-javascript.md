## Interacting with JavaScript


### Initialising the Lua global namespace

You can initialise the Lua global namespace with functions and values for your application. 
Simply add JavaScript keys and values to `window.starlight.config.env` *before* including the Starlight script.

The JavaScript functions can be called directly from within the Lua environment.

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua"&gt;
  print('API version:', <b>API_VERSION</b>)
  print('Time:', <b>getTimestamp()</b>)
&lt;/script&gt;
&nbsp;
&lt;script&gt;
  window.starlight = {
&nbsp;   config: {
&nbsp;     env: {
&nbsp;       <b>_API\_VERSION: 2,
&nbsp;       getTimestamp: function () {
&nbsp;         return Date.now();
&nbsp;       }</b>,
&nbsp;     },
&nbsp;   },
  };
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">API version: 2
Time:  1471725254319</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/reheru/edit?html,console">Run in JS Bin</a></figcaption>
</figure>

See also: [Creating Lua tables in JavaScript](#creating-lua-tables-in-javascript)



### Accessing the JavaScript world from Lua

The JavaScript `window` object is available in the Lua global namespace with the same name, but be aware `window ~= _G`. You need to access all JavaScript APIs and the DOM through the `window` table, for example:

<figure>
  <pre><code class="html">⋮
&lt;button id="click-me"&gt;Click me&lt;/button&gt;
&nbsp;
&lt;script type="application/lua"&gt;
  local button = <b>window.document:getElementById('click-me')
&nbsp;
  button:addEventListener('click', function () 
&nbsp;   window:alert('Hello!')
  end)</b>
&lt;/script&gt;
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/yefovo/edit?html,output">Run in JS Bin</a></figcaption>
</figure>


#### window.extract()

If you really want to access the properties of `window` in the global namespace, you can call `window.extract()`. 
Make sure you always use the colon syntax to call methods on the DOM, as in the examples above.

<figure>
  <pre><code class="html">⋮
&lt;button id="hello"&gt;Click me&lt;/button&gt;
&nbsp;
&lt;script type="application/lua"&gt;
  <b>window.extract()</b>
  local button = document:getElementById('hello')
&nbsp;
  button:addEventListener('click', function () 
&nbsp;   local p = document:createElement('p')
&nbsp;   p.textContent = 'Hello!!'
&nbsp;   document.body:appendChild(p)
  end)
&lt;/script&gt;
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/cococo/edit?html,output">Run in JS Bin</a></figcaption>
</figure>



### Creating Lua tables in JavaScript

Lua tables can be created in JavaScript and then be passed back into the Lua world.

When accessing properties of a Lua table object in JavaScript, you should use the `get()` and `set()` methods. `rawget()` and `rawset()` are also available to bypass metamethods. 

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua"&gt;
  local pos = getPosition();
  print('Latitude:', pos.lat)
  print('Longitude:', pos.lng)
&lt;/script&gt;
&nbsp;
&lt;script&gt;
  window.starlight = {
&nbsp;   config: {
&nbsp;     env: {
&nbsp;       getPosition: function () {
&nbsp;         <b>var pos = new starlight.runtime.T();
&nbsp;         pos.set('lat', 51.74257);
&nbsp;         pos.set('lng', -0.30186);</b>
&nbsp;         return pos;
&nbsp;       }
&nbsp;     }
&nbsp;   }
  };
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">Latitude:  51.74257
Longitude: -0.30186</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/zazaxi/edit?html,console">Run in JS Bin</a></figcaption>
</figure>

You can also pass a JavaScript object or array to the table constructor and the resulting table will be prepopulated with the correct values.

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua"&gt;
  local pos = getPosition();
  print('Latitude:', pos.lat)
  print('Longitude:', pos.lng)
&lt;/script&gt;
&nbsp;
&lt;script&gt;
  window.starlight = {
&nbsp;   config: {
&nbsp;     env: {
&nbsp;       getPosition: function () {
&nbsp;         return <b>new starlight.runtime.T({
&nbsp;           lat: 51.74257,
&nbsp;           lng: -0.30186,
&nbsp;         });</b>
&nbsp;       }
&nbsp;     }
&nbsp;   }
  };
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">Latitude:  51.74257
Longitude: -0.30186</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/sedifi/edit?html,console">Run in JS Bin</a></figcaption>
</figure>



### Calling Lua standard library functions

The Lua global namespace is accessible via `starlight.runtime._G`. This can be used to access and execute standard library functions.

Remember that `_G` is a Lua table and therefore we need to use `_G.get()` to access properties.

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua"&gt;
  local proxy = getProxy();
  local x = proxy.starlight
  proxy.rules = 'ok'
&lt;/script&gt;
&nbsp;
&lt;script&gt;
  window.starlight = {
&nbsp;   config: {
&nbsp;     env: {
&nbsp;       getProxy: function () {
&nbsp;         var t = new starlight.runtime.T();
&nbsp;         var mt = new starlight.runtime.T({
&nbsp;           __index: function (table, key) {
&nbsp;             console.log('GET', key);
&nbsp;           },
&nbsp;           __newindex: function (table, key, value) {
&nbsp;             console.log('SET', key, value)
&nbsp;           }
&nbsp;         });
&nbsp;           <b>starlight.runtime._G</b>.get('setmetatable')(t, mt);
&nbsp;         return t;            
&nbsp;       }
&nbsp;     }
&nbsp;   }
  };
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">GET   starlight
SET   rules    ok</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/palivoq/edit?html,console">Run in JS Bin</a></figcaption>
</figure>



### Returning multiple values from JavaScript

Simply return a JavaScript array containing the values. 

Remember that, if you wish to return a Lua array, you should return a Lua table. See [Creating Lua tables in JavaScript](#creating-lua-tables-in-javascript)

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua"&gt;
  <b>local lat, lng = getLatLng();</b>
  print('Latitude:', lat)
  print('Longitude:', lng)
&lt;/script&gt;
&nbsp;
&lt;script&gt;
  window.starlight = {
&nbsp;   config: {
&nbsp;     env: {
&nbsp;       getLatLng: function () {
&nbsp;         <b>return [51.74257, -0.30186];</b>
&nbsp;       }
&nbsp;     }
&nbsp;   }
  };
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">Latitude:  51.74257
Longitude: -0.30186</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/zukihi/edit?html,console">Run in JS Bin</a></figcaption>
</figure>



### Throwing Lua errors from JavaScript

When you expose your JavaScript API to the Lua world, you can also validate and throw Lua errors.

<figure>
  <pre><code class="html">⋮
&lt;button&gt;DO NOT CLICK!&lt;/button&gt;
&nbsp;
&lt;script&gt;
  var button = document.querySelector('button');
  button.addEventListener('click', function () {
&nbsp;   <b>throw new starlight.runtime.LuaError('Boooom!')</b>;
  });
&lt;/script&gt;  
⋮</code></pre>
<pre><code class="console">Uncaught LuaError: Boooom!</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/jokoxavugi/edit?html,console,output">Run in JS Bin</a></figcaption>
</figure>



