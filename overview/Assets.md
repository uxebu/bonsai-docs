---
title: Assets (Multimedia)
layout: doc
---

Bonsai currently supports five different asset types:

 * Audio
 * Bitmap
 * FontFamily
 * Movie
 * Video

Note: All Asset classes will resolve the asset path using the `assetBaseUrl` that you
can define when loading a movie ([more info on loading movies](/)). If it's not
defined then it'll fallback on the `baseUrl`, and if that's not defined then it'll
resolve the asset path against the page where the top-level movie is embedded.

### Audio

Loading and playing an audio track:

{% highlight javascript %}
var audio = new bonsai.Audio([
  {src: 'path/to/audio.m4a'},
  {src: 'path/to/audio.ogg'}
]);

audio.on('load', function(){
  audio.play();
});

stage.addChild(audio);
{% endhighlight %}

**Note:** On iOS devices, Audio can only be played in reaction to a user event.
To make this work with bonsai's inherently asynchronous architecture you'll need
to call `audio.prepareUserEvent()`. And then you can freely bind to user-events
and play the audio in reaction, like so:

{% highlight javascript %}
audio.prepareUserEvent(); // Needed for iOS devices
someButton.on('click', function() {
  audio.play();
});
{% endhighlight %}

### Bitmap

Loading and displaying a Bitmap:

{% highlight javascript %}
new Bitmap('path/to/image.png').on('load', function() {
  this.addTo(stage);
});
{% endhighlight %}

### Movie

To embed a sub-movie from within your current movie you would do:

{% highlight javascript %}
// It is best to wait for an asset to
// load before adding it to the stage

new Movie('path/to/sub-movie.js').on('load', function() {
  this.addTo(stage); // Add the loaded sub-movie to the stage
});
{% endhighlight %}

### Video

Loading and displaying a video:

{% highlight javascript %}
var video = new bonsai.Video([
  {src: 'assets/sample_iPod.m4v', type:'video/mp4'},
  {src: 'assets/sample.ogv', type:'video/ogg'}
]).attr({
  y: 150,
  x: 150,
  width:320,
  height:240
});

stage.addChild(video);
{% endhighlight %}

### FontFamily

See the [Custom Fonts Overview](/overview/CustomFonts.html)

