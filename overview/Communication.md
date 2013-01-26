---
title: Communication
layout: doc
---

After reading about the [Execution of Bonsai code](/overview/Execution.html) you should understand that
you can't access certain browser functionality (e.g. DOM) from within a Bonsai movie. Because of that
Bonsai provides a messaging channel to communicate from and to the runner context.

This is how you would communicate from/to the page to/from your Bonsai movie:

{% highlight html %}
<script src="http://cdnjs.cloudflare.com/ajax/libs/bonsai/0.4/bonsai.min.js"></script>
<div id="movie"></div>
<script>
  var movie = bonsai.run(
    document.getElementById('movie'), {
      code: function() {
        // receive data from the other side
        var text = new Text().addTo(stage);
        stage.on('message:externalData', function(data) {
          text.attr('text', data.nodeData);
        });
        stage.on('message', function(data) {
          if (data.bonsai === 'tree') {
            text.attr('textFillColor', 'red');
          }
        });
        stage.sendMessage('ready', {});
      }
    }
  );
  // emitted before code gets executed
  movie.on('load', function() {
    // receive event from the runner context
    movie.on('message:ready', function() {
      // send a categorized message to the runner context
      movie.sendMessage('externalData', {
        nodeData: document.getElementById('movie').innerHTML
      });
      // send just a message to the runner context
      movie.sendMessage({
        bonsai: 'tree'
      });
    });
  });
</script>
{% endhighlight %}
