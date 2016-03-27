## Using Starlight with Grunt

It is recommended that you precompile your Lua code to JavaScript and serve only the JavaScript. 
This negates the need to include the ~800k Babel browser lib in your page.

### Install

To do this, you'll need to install the Starlight Grunt plugin. You'll also need Babel and to support Chrome you'll also need Babel's destructuring transform.

    npm install grunt-starlight grunt-babel babel-plugin-transform-es2015-destructuring --save-dev

### Configure

Then, in your Gruntfile:

    grunt.initConfig({
      starlight: {
        'hello-world': {
          src: 'src/lua/hello-world.lua',
          dest: 'dist/js/hello-world.lua.js',
        }
      },
      babel: {
        options: {
          plugins: ['transform-es2015-destructuring'],
        },
        'hello-world': {
          src: 'dist/js/hello-world.lua.js',
          dest: 'dist/js/hello-world.lua.js',
          }
        }
      }
    });

See also: [Grunt hello world example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-hello-world)

You may also build many Lua files into a single JavaScript file, like the following example for building Starlight's own tests. 
Remember to set which file will execute first using `options.main`.

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

See also: [Grunt with modules example](https://github.com/paulcuth/starlight-examples/tree/master/grunt-with-modules)
