---
title: Architecture
layout: doc
---

### How to run a Bonsai movie

We currently offer two separate builds of bonsai, `bonsai.js` which is the worker-context-build and `bonsai.iframe.js` which is the iframe-context-build.

 * iFrame context -- loads JS and runs movie code within an iframe, providing a sandboxed environment and very debuggable.
 * Worker context -- loads JS and runs movie code within a Worker instance, providing a sandboxed environment, with theoretic performance improvements (no UI blocking for expensive operations) but potentially lacking debugability.

So, for development we usually recommend `bonsai.iframe.js`.

Here's an overview of how Bonsai operates:

<img src="/assets/bonsai-overview.png" alt="Bonsai separated architecture, showing parent page and runner-context where the actual bonsai movie is run" />

Bonsai will reveal itself as simply `bonsai` on the parent page. The actual API (e.g. `Shape`, `stage.addChild()` etc.) will only be available within the specified context. The API revealed on the parent page currently only allows loading of movies, like so:

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

