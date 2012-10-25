---
title: Architecture
layout: doc
---

Bonsai movies can be executed in two contexts:

 * iFrame context -- loads JS and runs movie code within an iframe, providing a sandboxed environment and very debuggable.
 * Worker context -- loads JS and runs movie code within a Worker instance, providing a sandboxed environment, with theoretic performance improvements (no UI blocking for expensive operations) but potentially lacking debugability.

The built version of Bonsai is taking care to select the best approach for a particular browser:

* Worker-Environment spawned with Blob (latest Chrome, Firefox, Safari 6 and iOS 6)
* Worker-Environment spawned with Data-URI (Opera 12)
* Iframe-Environment spawned through `<script>/*bonsaiCode*/</script>` (older Chrome versions, Safari 5, IE 9/10. Note: IE10 throws a security error, if a Blob-URL is used as the Worker source)

To just allow the bonsai-code to be executed in the iframe context you can do the following:

{% highlight javascript %}
bonsai.setup({
  runnerContext: bonsai.IframeRunnerContext
}).run(stage, 'movie.js');
{% endhighlight %}

Or if you want to limit it to the worker context which loads bonsai through a URL you can do the following:

{% highlight javascript %}
bonsai.setup({
  runnerContext: bonsai.WorkerRunnerContext,
  runnerUrl: 'http://url/to/bonsai.js'
}).run(stage, 'movie.js');
{% endhighlight %}

Here's an overview of how Bonsai operates:

<img src="/assets/bonsai-overview.png" alt="Bonsai separated architecture, showing parent page and runner-context where the actual bonsai movie is run" />

Bonsai will reveal itself as simply `bonsai` on the parent page. The actual API (e.g. `Shape`, `stage.addChild()` etc.) will only be available within the specified context. The API revealed on the parent page currently allows loading of movies, like so:

{% highlight html %}
<div id="movie"></div>

<script src="bonsai.iframe.js"></script>
<script>
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

There are two available signatures for loading a single movie:

{% highlight javascript %}
bonsai.run(element, movieUrl, { /* options */ });
bonsai.run(element, { url: movieUrl /*, ... other options */ });
{% endhighlight %}

