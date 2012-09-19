---
title: Custom Fonts
layout: doc
---

Bonsai allows you to define and use custom fonts. You will usually want to
include the font in several formats to support various browsers.

See [MyFonts' Browser Support Overview](http://webfonts.info/browser-support-overview)
for more details on browser support.

### Applying a custom font:

{% highlight javascript %}
new FontFamily('myFontFamily', [
  'path/to/myfont.woff',
  'path/to/myfont.eot',
  'path/to/myfont.ttf',
  'path/to/myfont.svg'
]);

new Text('Just testing my font').attr({
  x: 50,
  fontSize: 40,
  fontFamily:'myFontFamily'
}).addTo(stage);
{% endhighlight %}

For more information on loading various assets please see the
[Assets overview](/overview/Assets.html)