---
title: Introduction
layout: doc
---

You've found the Bonsai API documentation site. Welcome!

Bonsai is a graphics library which includes an intuitive graphics API and an SVG renderer.

What does Bonsai look like?

<!--runnable:{height:200}-->
{% highlight javascript %}
var square = new Rect(0, 0, 100, 100);

square.addTo(stage);
square.fill('red');
square.animate('1.5s', {
  rotation: Math.PI,
  x: 700,
  fillColor: 'green'
});
{% endhighlight %}

### Bonsai playground

If you want to try out the features of Bonsai, go ahead and [try out Orbit](http://orbit.bonsaijs.org/ "Orbit"), the online editor for Bonsai.

### Lets get started

Before you start digging into the docs, take out your favourite Editor and check out following example:

{% highlight html %}
<script src="http://cdnjs.cloudflare.com/ajax/libs/bonsai/0.4/bonsai.min.js"></script>
<div id="movie"></div>
<script>
  bonsai.run(document.getElementById('movie'), {
    code: function() {
      new Rect(10, 10, 100, 100)
        .addTo(stage)
        .attr('fillColor', 'green');
    },
    width: 500,
    height: 400
  });
</script>
{% endhighlight %}

The only thing to mention here is the fact that you provided your Bonsai code within the function body
assigned to the code property (Note: this function is executed in a different context and you can't access
properties from the scope where `bonsai.run` was called). This is the fast lane, usually you would put
your Bonsai code into separate files and you would do something like:

{% highlight html %}
<script src="http://cdnjs.cloudflare.com/ajax/libs/bonsai/0.4/bonsai.min.js"></script>
<div id="movie"></div>
<script>
  bonsai.run(document.getElementById('movie'), {
    url: 'movie.js',
    width: 500,
    height: 400
  });
</script>
{% endhighlight %}

Or you chose the short form (passing `movie.js` as second parameter instead of the configuration object):

{% highlight html %}
<script src="http://cdnjs.cloudflare.com/ajax/libs/bonsai/0.4/bonsai.min.js"></script>
<div id="movie"></div>
<script>
  bonsai.run(document.getElementById('movie'), 'movie.js');
</script>
{% endhighlight %}

Details which parameters can be passed in options and how you can configure the execution context can be found on the
[Execution overview](/overview/Execution.html).

### Browser support

Bonsai in its current form comes packaged with an SVG renderer. The following browsers/platforms are supported:

 * Safari >= 5
 * Chrome >= 20
 * Firefox >= 18
 * Opera >= 12
 * IE >= 9

### How to use the docs

The docs are split up in two parts:

1. User docs, introductions and conecpts

    This part of the documentation is helping you to get a better general
    understanding of how Bonsai works. Take a look at the "Overview" section
    to get a feeling for what is supported and to see some examples of Bonsai
    in action

2. API docs

    The API docs are the source for detailed information regarding the API.
    This is the place to be if you want to look up the nuts and bolts and
    want to see in detail what the Bonsai API offers.
