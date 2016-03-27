## Interacting with JavaScript


### Initialising the Lua global namespace

You can initialise the Lua global namespace with functions and values for your system. 
Simply add JavaScript keys and values to `window.starlight.config.env` *before* including the Starlight script.

The JavaScript functions can be called directly from within the Lua environment.

<a class="jsbin-embed" href="http://jsbin.com/reheru/embed?html,console">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>

See also: [Creating Lua tables in JavaScript](#creating-lua-tables-in-javascript)



### Accessing the JavaScript world from Lua

The JavaScript `window` object is available with the same name, but be aware `window ~= _G`. You need to access all JavaScript APIs and the DOM through the `window` table, for example:

    <script type="application/lua">
      window:alert('hello')
      window.document:createElement('div')
      window.navigator.geolocation:getCurrentPosition(successCallback, failCallback)
    </script>

<a class="jsbin-embed" href="http://jsbin.com/yefovo/embed?html,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>


#### window.extract()

If you really want to access the properties of `window` in the global namespace, you can call `window.extract()`.

    <script type="application/lua">
      window.extract()

      alert('hello')
      document:createElement('div')
      navigator.geolocation:getCurrentPosition(successCallback, failCallback)
    </script>

Make sure you always use the colon syntax to call methods on the DOM, as in the examples above.

<a class="jsbin-embed" href="http://jsbin.com/cococo/embed?html,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>



### Creating Lua tables in JavaScript

Lua tables can be created in JavaScript and then be passed back into the Lua world.

The properties on a Lua table object muct be accessed via `get()` and `set()` methods. `rawget()` and `rawset()` are also available to bypass metamethods. 

<a class="jsbin-embed" href="http://jsbin.com/zazaxi/embed?html,console"> on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>

You can also pass a JavaScript object or Array to the table constructor and the resulting table will be prepopulated with the correct values.

<a class="jsbin-embed" href="http://jsbin.com/sedifi/embed?html,console">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>



### Calling Lua standard library functions

The Lua global namespace is accessible via `starlight.runtime._G`. This can be used to access and execute standard library functions.

Remember that `_G` is a Lua table and therefore we need to use `_G.get()` to access properties.

<a class="jsbin-embed" href="http://jsbin.com/palivoq/embed?html,console">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>



### Returning multiple values from JavaScript

Simply return a JavaScript Array containing the values. 

Remember that if you wish to return a Lua array, you should return a Lua table. See [Creating Lua tables in JavaScript](#creating-lua-tables-in-javascript)

<a class="jsbin-embed" href="http://jsbin.com/zukihi/embed?html,console">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>



### Throwing Lua errors from JavaScript

When you expose your JavaScript API to the Lua world, you can also validate and throw Lua errors.

<a class="jsbin-embed" href="http://jsbin.com/zeyiha/embed?html,console">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.11"></script>







