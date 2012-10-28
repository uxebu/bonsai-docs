---
title: Text
layout: doc
---

Bonsai's Text class can be used to display Text in the stage:

<!--runnable-->
{% highlight javascript %}
new Text('Look at me').addTo(stage).attr({
  fontFamily: 'Arial, sans-serif',
  fontSize: '20',
  textFillColor: 'red',
  textStrokeColor: 'yellow',
  textStrokeWidth: 3
});
{% endhighlight %}

### Attributes

 * `textFillColor`: The color of the text
 * `textStrokeColor`: The color of the outline of the text
 * `textStrokeWidth`: The width of the outline of the text
 * `fontFamily`: Font family (a string or a FontFamily instance, see [custom fonts](/overview/CustomFonts.html))
 * `fontSize`: Font size (pixels)
 * `fontStyle`: `normal` or `italic` or `oblique`
 * `selectable`: Boolean indicating whether the text is selectable or not
 * `text`: The actual text-content of the Text instance

### Positioning

Text instances will, by default, be anchored to the top-left. This means that
whatever you set `x` and `y` to is where the top-left of the text will display.

### Mutating content

To change the content of a Text instance, you can use the `text` attribute:

{% highlight javascript %}
var myText = new Text('foo');
myText.attr('text'); // => 'foo'

// Change content:
myText.attr('text', 12345);
{% endhighlight %}