## Using Starlight with Grunt

It is recommended that you precompile your Lua code to JavaScript and serve only the JavaScript. 
This negates the need to include the ~800k Babel browser lib in your page.

### Install

To do this, you'll need to install the Starlight Grunt plugin. You'll also need Babel and to support Chrome you'll also need Babel's destructuring transform.

<figure>
  <pre><code class="shell">npm install grunt-starlight grunt-babel babel-plugin-transform-es2015-destructuring --save-dev</code></pre>
</figure>

### Configure

Then, in your Gruntfile:

<figure>
  <pre><code class="gruntfile">grunt.loadNpmTasks('grunt-starlight');
grunt.loadNpmTasks('grunt-babel');
&nbsp;
grunt.initConfig({
  <b>starlight: {
&nbsp;   counter: {
&nbsp;     src: 'src/counter-app.lua',
&nbsp;     dest: 'dist/counter-app.es6.js',
&nbsp;   }
  }</b>,
&nbsp;
&nbsp; babel: {
&nbsp;   options: {
&nbsp;     plugins: ['transform-es2015-destructuring']
&nbsp;   },
&nbsp;   counter: {
&nbsp;     src: 'dist/counter-app.es6.js',
&nbsp;     dest: 'dist/counter-app.js',
&nbsp;   }
  }
});
&nbsp;
grunt.registerTask('default', ['starlight:counter', 'babel:counter']);</code></pre>
</figure>




### Serve

All you need to include in the page is the Starlight runtime and your built script, plus any markup required by your app.

Note that you do not need to include Babel in the page when building in advance.

<figure>
  <pre><code class="html">&lt;!DOCTYPE html&gt;
&lt;html&gt;
  &lt;body&gt;
&nbsp;   &lt;h1&gt;Counter app&lt;/h1&gt;
&nbsp;   &lt;p class="result"&gt;0&lt;/p&gt;
&nbsp;   &lt;p&gt;&lt;button&gt;+1&lt;/button&gt;&lt;/p&gt;
&nbsp;
&nbsp;   <b>&lt;script src="http://paulcuth.me.uk/starlight/browser-lib/starlight.js"&gt;&lt;/script&gt;
&nbsp;   &lt;script src="http://paulcuth.me.uk/starlight/compiled/counter-app.js"&gt;&lt;/script&gt;</b>
&nbsp; &lt;/body&gt;
&lt;/html&gt;</code></pre>
  <figcaption class="js-bin"><a href="http://jsbin.com/casocav/edit?html,output">Run in JS Bin</a></figcaption>
</figure>

See also: [Grunt counter app example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-counter-app)



### Package

You can also build many Lua files into a single JavaScript file, like the following example for building Starlight's own tests. 
Remember to set which file will execute first using `options.main`.

<figure>
  <pre><code class="gruntfile">grunt.loadNpmTasks('grunt-starlight');
grunt.initConfig({
  starlight: {
&nbsp;   test: {
&nbsp;     src: 'test/lua/**/*.lua',
&nbsp;     dest: 'dist/test/test.lua.js',
&nbsp;     options: {
&nbsp;       main: 'test-runner.lua',
&nbsp;       basePath: 'test/lua'
&nbsp;     }
&nbsp;   }
&nbsp;   // ...
  }
});</code></pre>
</figure>

See also: [Grunt with modules example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-modules)
