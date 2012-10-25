---
title: Execution
layout: doc
---

Bonsai movies can be executed in two execution contexts (we call it the runner):

* iFrame runner context -- loads JS and runs movie code within an iframe, providing a sandboxed environment. It is used for browsers
  that don't support workers and it makes debugging Bonsai more easy.
* Worker runner context -- loads JS and runs movie code within a Worker instance, providing a sandboxed environment, with theoretic performance improvements (no UI blocking for expensive operations) but potentially lacking debugability.

The built version of Bonsai is taking care to select the best approach for a particular browser (determined through 
feature detection):

* Worker context is created through Blob (latest Chrome, Firefox, Safari 6 and iOS 6)
* Worker context is created through Data-URI (Opera 12)
* Iframe context is created through `<script>/*bonsaiCode*/</script>` (older Chrome versions, Safari 5, IE 9/10. Note: IE10 throws a security error, if a Blob-URL is used as the Worker source)

So if you use the built version of Bonsai (e.g. from CDNJS), it will take care of the right strategy for you: 

{% highlight html %}
<script src="http://cdnjs.cloudflare.com/ajax/libs/bonsai/0.4/bonsai.min.js"></script>
<div id="movie"></div>
<script>
  bonsai.run(document.getElementById('movie'), 'movie.js');
</script>
{% endhighlight %}

There are cases where you want to force the Bonsai runner context to be the iFrame. You can achieve this behaviour like that:

{% highlight javascript %}
bonsai.setup({
  runnerContext: bonsai.IframeRunnerContext
}).run(stageNode, 'movie.js');
{% endhighlight %}

There are some environments where we can't automatically create the worker environment through a Blob- or Data-URI 
(e.g. iOS 5 and Safari 5). If you can accept to exclude browsers that don't support web workers you can limit the execution
to the worker context and additionally feed it the original `bonsai.js` as runner URL to reach all browsers that have worker 
support (Note: you need to load `bonsai.js` from the same domain, where the original page is served from, to avoid cross domain
issues):

{% highlight javascript %}
bonsai.setup({
  runnerContext: bonsai.WorkerRunnerContext,
  runnerUrl: 'bonsai.js'
}).run(stageNode, 'movie.js');
{% endhighlight %}

Here's an overview of how Bonsai operates:

<img src="/assets/bonsai-overview.png" alt="Bonsai separated architecture, showing parent page and runner-context where the actual bonsai movie is run" />

As seen before, Bonsai will reveal itself as simply `bonsai` on the parent page. The actual API (e.g. `Shape`, `stage.addChild()` etc.) will only be available within the specified context. The API revealed on the parent page currently allows loading of movies, like so:

{% highlight javascript %}
bonsai.run(
  document.getElementById('movie'),
  'path/to/my_movie.js',
  {
    width: 500,
    height: 400
  }
);
</script>
{% endhighlight %}

Options you can pass to `bonsai.run()` include:

 * `width` (Number) -- Pixel width of the movie
 * `height` (Number) -- Pixel height of the movie
 * `framerate` (Number) -- FPS (frames per second) of movie
 * `baseUrl` (String) -- Base URL used to resolve movie and plugin URLs
 * `assetBaseUrl` (String) -- Base URL used to resolve any assets loaded within movies
 * `urls` (Array) -- Array of movie URLs to load (all relative to the optional `baseUrl`)
 * `url` (String) -- URL of movie (relative to the optional `baseUrl`)
 * `plugins` (Array) -- Array of plugin URLs to load (all relative to the optional `baseUrl`)
 * `code` (String) -- JavaScript code to run directly as a movie

There are three available signatures for loading/executing a single movie:

{% highlight javascript %}
bonsai.run(element, movieUrl, { /* options */ });
bonsai.run(element, { url: movieUrl /*, ... other options */ });
bonsai.run(element, { code: '' /* string|function */ /*, ... other options */ });
{% endhighlight %}
