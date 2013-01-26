---
title: Loading
layout: doc
---

BonsaiJS allows it to load JavaScript code into the [runner context](/overview/Execution.html),
so that you can use other libraries like [RequireJS](http://requirejs.org),
[Lo-Dash](http://lodash.com) or [any BonsaiJS plugin](https://github.com/bonsai-plugins)
in your BonsaiJS code.

**Note**: Libraries that access the DOM (`document`, `window`, ...), like jQuery, can't be loaded in
Bonsai's runner context. See [Execution Overview](overview/Execution.html) for details about those 
limitations.

### JS Execution

The following BonsaiJS `run` options allow it to load JavaScript code into the BonsaiJS context:

~~~js
var el = document.getElementById('movie');
bonsai.run(el, {
  baseUrl: '.',
  urls: ['foo.js', 'bar.js'],
  url: 'baz.js',
  code: 'console.log("foo");',
  // or as function (for syntax highlighting). will be stringified
  // code: function() {
  //   console.log("foo");
  // }
  // see `Using RequireJS` below 
  requirejsConfig: {
    // RequireJS configuration details: http://requirejs.org/docs/api.html#config
    // baseUrl: '.',
    // paths: {},
    // shim: {},
    // for cache busting
    // urlArgs: +new Date 
  }
});
~~~

URLs within `urls` and `url` will be resolved relative to `baseUrl`, which defaults to the 
current page URL. All URLs will be loaded in parallel and JS code gets executed in the following 
order:

1. `urls` in Array order
2. `url`
3. `code`

For executing Bonsai-code you don't have to fill out every `run` option. One option is sufficient.

### Loading several JS files

To load the JS files `foo.js` and `bar.js` into your BonsaiJS context you have to pass them to 
the `urls` option:

~~~js
bonsai.run(el, {
  urls: ['foo.js', 'bar.js']
});
~~~

Both files will be resolved relative to the current URL (e.g. if the above code would be part of 
http://127.0.0.1/bonsai.html, it would load `foo.js` from http://127.0.0.1/foo.js). If you
want to change that behaviour you can set the `baseUrl` through the passed options:

~~~js
bonsai.run(el, {
  baseUrl: 'js/',
  // would load files from http://127.0.0.1/js/foo.js
  urls: ['foo.js', 'bar.js']
});
~~~

### Expose functionality

When loading files via `urls` you expect that you can use the loaded functionality. Files
that are loaded through `urls` can simply just set a variable or set a property on `this`,
so that JS code that is executed afterwards can access those exposed properties (similar
to loading a script-tag on a normal HTML page):

~~~ js
bonsai.run(el, {
  urls: ['foo.js'],
  code: function() {
    console.log(foo); // prints: bar
    console.log(round(1.337)); // prints: 1
    console.log(this.foo); // prints: bar
    console.log(this.bar); // prints: baz
  }
});
~~~

~~~ js
// foo.js

// expose property as variable declaration
var foo = 'bar';

// expose property through `this` 
(function(){
  this.round = function(a) {
    return Math.round(a);
  };
})(this);
// or
this.bar = 'baz';
~~~

Because BonsaiJS loading mechanism behaves like loading script tags on a HTML page, you can 
load other JS libraries like [RequireJS](http://requirejs.org) or [Lo-Dash](http://lodash.com):

~~~ js
bonsai.run(el, {
  urls: [
    'http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.4/require.min.js',
    'http://cdnjs.cloudflare.com/ajax/libs/lodash.js/1.0.0-rc.3/lodash.min.js'
  ],
  // will be executed after `urls` got loaded and executed
  code: function() {
    console.log(require.toString());
    console.log(
      _.map([1, 2, 3], function(num) { return num * 3; });
    );
  }
});
~~~

### Using RequireJS

For larger BonsaiJS projects it makes sense to separate your JS code into several modules during development.
Because of that BonsaiJS has support for [RequireJS](http://requirejs.org), which allows loading AMD modules:

~~~ js
bonsai.run(el, {
  urls: [
    'http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.4/require.min.js',
    'movie.js'
  ]
})

// movie.js
require(['./module1', './module2'], function(mod1, mod2) {
  console.log(mod1.foo); // prints: bar
  console.log(mod2.foo); // prints: baz
  console.log(mod2.mod3.bar); // prints: baz
});

// module1.js
define(function() {
  return {
    foo: 'bar'
  }
});

// module2.js
define(['./module3'], function(mod3) {
  return {
    foo: 'baz',
    mod3: mod3
  }
});

// module3.js
define(function() {
  return {
    bar: 'baz'
  }
});
~~~

The builtin RequireJS support takes care, that the RequireJS configuration in the runner context
is equal to the RequireJS configuration of the original page and that the loading / execution order
(see `JS Execution` above) is preserved.

Assume RequireJS was loaded on the page already and you've configured it like that:

~~~ html
<!-- my page -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.4/require.min.js"></script>
<script>
  require.config({
    baseUrl: './foo/bar',
    paths: {
      custom1: './custom1',
      custom2: './custom2'
    }
  });
</script>
~~~

When you now load RequireJS into Bonsai you can simply access modules like that:

~~~ js
<!-- my page -->
<!-- code from above ... -->
<script>
  var el = document.getElementById('movie');
  bonsai.run(el, {
    urls: ['http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.4/require.min.js'],
    code: function() {
      // of course you could still configure custom paths here:
      // require.config({ ... });
      require(['custom1/foo'], function(foo) {
        // this would load foo.js from `PAGE-URL/./foo/bar/./custom1/foo.js`
      });
    }
  });
</script>
~~~

