## Using Starlight with Grunt

It is recommended that you precompile your Lua code to JavaScript and serve only the JavaScript. 
This negates the need to include the ~800k Babel browser lib in your page.

### Install

To do this, you'll need to install the Starlight Grunt plugin. You'll also need Babel and to support Chrome you'll also need Babel's destructuring transform.

    npm install grunt-starlight grunt-babel babel-plugin-transform-es2015-destructuring --save-dev

### Configure

Then, in your Gruntfile:

    grunt.loadNpmTasks('grunt-starlight');
    grunt.loadNpmTasks('grunt-babel');

    grunt.initConfig({
      starlight: {
        counter: {
          src: 'src/counter-app.lua',
          dest: 'dist/counter-app.es6.js',
        }
      },

      babel: {
        options: {
          plugins: ['transform-es2015-destructuring']
        },
        counter: {
          src: 'dist/counter-app.es6.js',
          dest: 'dist/counter-app.js',
        }
      }
    });

    grunt.registerTask('default', ['starlight:counter', 'babel:counter']);




### Serve

All you need to include in the page is the Starlight runtime and your built script, plus any markup required by you app.

Note that you do not need to include Babel in thepage when building in advance.

<a class="jsbin-embed" href="http://jsbin.com/casocav/embed?html,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.35.12"></script>

See also: [Grunt counter app example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-counter-app)



### Package

You can also build many Lua files into a single JavaScript file, like the following example for building Starlight's own tests. 
Remember to set which file will execute first using `options.main`.

    grunt.loadNpmTasks('grunt-starlight');
    grunt.initConfig({
      starlight: {
        test: {
          src: 'test/lua/**/*.lua',
          dest: 'dist/test/test.lua.js',
          options: {
            main: 'test-runner.lua',
            basePath: 'test/lua'
          }
        }
        // ...
      }
    });

See also: [Grunt with modules example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-modules)
