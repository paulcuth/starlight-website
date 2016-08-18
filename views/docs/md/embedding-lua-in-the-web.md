
## Embedding Lua in the Web

### Hello world

Starlight enables you to run Lua scripts in a webpage by placing Lua code in `<script>` tags. 
Here's a simple example:

<figure>
  <pre><code class="html">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;body&gt;
&nbsp;
  <b>&lt;script type="application/lua"&gt;
  &nbsp;&nbsp;print('Hello world')
  &lt;/script&gt;
&nbsp;
  &lt;script src="//cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.34/browser.min.js"&gt;&lt;/script&gt;
  &lt;script src="http://paulcuth.me.uk/starlight/browser-lib/starlight.js" data-run-script-tags&gt;&lt;/script&gt;</b>
&nbsp;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
<pre><code class="console">Hello world</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/rovibad/edit?html,console">Run in JS Bin</a></figcaption>
</figure>

As you can see we wrap the Lua code in a `<script>` tag with `type="application/lua"`. This tells the browser not to parse it as JavaScript and also tells Starlight that it should parse and translate the code within.

We're also including the Babel browser runtime because Starlight outputs ES6 and, for the time being at least, most browsers do not fully support ES6. Hopefully over time the need to include Babel will reduce significantly. See also [Using Starlight with Grunt](./using-starlight-with-grunt) to discover how to precompile your scripts and negate the need for Babel.

You'll also need to include Starlight itself. We're using the boolean attribute `data-run-script-tags` here to tell Starlight to execute the scripts on page load. Without this attribute the scripts will need to be executed manually.

That's all you need to get started. Notice that the `print()` function will output to the browser's console window. This can be modified in the Starlight configuration.


#### MIME types

Starlight will parse any `<script>` tags with the following `type`s:

- text/lua
- text/x-lua
- application/lua
- application/x-lua



### Including remote scripts

As with JavaScript, you can also include and execute Lua from remote scripts using the `src` attribute. 
One difference, however, is that files are loaded over [<attr title="XMLHttpRequest">XHR</attr>](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest), so the remote scripts will need to adhere to [<attr title="Cross-Origin Resource Sharing">CORS</attr>](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS).

<figure>
  <pre><code class="html">⋮
  &lt;p class="result"&gt;0&lt;/p&gt;
  &lt;p&gt;&lt;button&gt;+1&lt;/button&gt;&lt;/p&gt;
&nbsp;
  &lt;script type="application/lua" <b>src="http://paulcuth.me.uk/starlight/lua/counter-app.lua"</b>&gt;&lt;/script&gt; 
&nbsp;
  &lt;script src="//cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.34/browser.min.js"&gt;&lt;/script&gt;
  &lt;script src="http://paulcuth.me.uk/starlight/browser-lib/starlight.js" data-run-script-tags&gt;&lt;/script&gt;
⋮</code></pre>

  [counter-app.lua](http://paulcuth.me.uk/starlight/lua/counter-app.lua)

  <pre><code class="lua">window.extract()
local counter = 0
&nbsp;
local ui = {
  button = document:getElementsByTagName('button')[1],
  result = document:querySelector('.result'),
}
&nbsp;
function updateUI ()
  ui.result.textContent = counter
end
&nbsp;
function increment ()
  counter = counter + 1
  updateUI()
end
&nbsp;
function init () 
  updateUI()
  ui.button:addEventListener('click', increment)
end
&nbsp;
init()</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/mohoci/edit?html,console">Run in JS Bin</a></figcaption>
</figure>



Scripts are loaded and parsed in the order that they appear in the page. 
You can add a `defer` attribute to defer the loading of the script until after others have loaded, so that your script does not block.
The `defer` attribute is ignored on inline script tags.



### Modules

You can also turn your script tag into a Lua module by giving it a `data-modname` attribute. 
This script will be preloaded but not executed and can later be required by any other Lua script. 
Make sure you define a module in a tag that precedes those that require it, in the order they appear in the page.

<figure>
  <pre><code class="html">⋮
&lt;script type="application/lua" <b>data-modname="fibonacci"</b>&gt;
&nbsp; function fibonacci(n)
&nbsp;   a, b = 0, 1
&nbsp;   for i = 1, n do
&nbsp;     a, b = b, a + b
&nbsp;   end
&nbsp;   return a
&nbsp; end
&nbsp;
&nbsp; return fibonacci
&lt;/script&gt;
&nbsp;
&lt;script type="application/lua"&gt;
&nbsp; local fib = <b>require('fibonacci')</b>
&nbsp; print(fib(500))
&lt;/script&gt;
⋮</code></pre>
<pre><code class="console">1.394232245616977e+104</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/gadequp/edit?html,console">Run in JS Bin</a></figcaption>
</figure>


The `data-modname` attribute can also be used on remote script tags.
When using script tags, all modules need to be explicitly defined within the page; using `require()` with a relative file path will fail unless the required script is defined in the markup. This does not apply when you use Starlight to precompile your Lua to JavaScript, see [Using Starlight with Grunt](./using-starlight-with-grunt) for more information.

<figure>
  <pre><code class="html">⋮
  &lt;p&gt;
&nbsp;   &lt;input value="20" /&gt;
&nbsp;   &lt;button&gt;Fibonacci&lt;/button&gt;
  &lt;/p&gt;
  &lt;p class="result"&gt;&lt;/p&gt;
&nbsp;
  &lt;script type="application/lua" src="http://paulcuth.me.uk/starlight/lua/fibonacci-module.lua" <b>data-modname="fibonacci"</b>&gt;&lt;/script&gt;
  &lt;script type="application/lua" src="http://paulcuth.me.uk/starlight/lua/fibonacci-app.lua"&gt;&lt;/script&gt;
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/guteqikovu/edit?html,output">Run in JS Bin</a></figcaption>
</figure>

[fibonacci-module.lua](http://paulcuth.me.uk/starlight/lua/fibonacci-module.lua) / 
[fibonacci-app.lua](http://paulcuth.me.uk/starlight/lua/fibonacci-app.lua)



### Executing Lua programmatically from JavaScript

You can use Starlight to execute arbitrary Lua code from within JavaScript, using `starlight.parser.parse()`.

<figure>
  <pre><code class="html">⋮
&lt;button id="click-me"&gt;Click me&lt;/button&gt;
&nbsp;
&lt;script&gt;
&nbsp; var button = document.getElementById('click-me');
&nbsp; button.addEventListener('click', function () {
&nbsp;   var lua = "print('Button clicked!!')";
&nbsp;   <b>var handler = starlight.parser.parse(lua);</b>
&nbsp;   handler();
&nbsp; });
&lt;/script&gt; 
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/rutoni/edit?html,console,output">Run in JS Bin</a></figcaption>
</figure>

A nice way to use the parser in this manner is to place the Lua code in script tags and execute these on demand. In this case, remember to prevent your Lua scripts from executing on page load, by not adding the `data-run-script-tags` attribute.

<figure>
  <pre><code class="html">⋮
&lt;button id="click-me"&gt;Click me&lt;/button&gt;
&nbsp;
&lt;script type="application/lua" <b>id="click-handler"</b>&gt;
&nbsp; print('Button clicked!!')
&lt;/script&gt;
&nbsp;
&lt;script&gt;
&nbsp; function init () {
&nbsp;   var lua = <b>document.getElementById('click-handler').textContent;</b>
&nbsp;   var handler = <b>starlight.parser.parse(lua);</b>
&nbsp;
&nbsp;   var button = document.getElementById('click-me');
&nbsp;   button.addEventListener('click', handler);
&nbsp; }
&nbsp;
&nbsp; window.addEventListener('load', init);
&lt;/script&gt;  
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/coheya/edit?html,console,output">Run in JS Bin</a></figcaption>
</figure>



### Configuration

Starlight can be configured by creating a configuration object in JavaScript *before* including the Starlight browser library.

The configuration object is `window.starlight.config` and can currently be used to override the destination of `stdout` and add variables to the Lua global namespace.

In the following example, we are redirecting the `stdout` to output to a DOM element instead of the browser's console window.

<figure>
  <pre><code class="html">⋮
&lt;pre id="output"&gt;&lt;/pre&gt;
&nbsp;
&lt;script type="application/lua"&gt;
&nbsp; print('Hello world')
&lt;/script&gt;
&nbsp;
&lt;script&gt;
&nbsp; var outputEl = document.getElementById('output');
&nbsp;
&nbsp; <b>window.starlight = {
&nbsp;   config: {
&nbsp;     stdout: {
&nbsp;       writeln: function () {
&nbsp;         var args = Array.prototype.splice.call(arguments, 0);
&nbsp;         outputEl.textContent += args.join('\t');
&nbsp;       }
&nbsp;     }
&nbsp;   }
&nbsp; };</b>
&lt;/script&gt;  
⋮</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/silezu/edit?html,output">Run in JS Bin</a></figcaption>
</figure>

To use the configuration object to initialise the Lua global environment, see [Interacting with JavaScript](./interacting-with-javascript).



