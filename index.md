---
title: Introduction
layout: doc
---

You've found the Bonsai API documentation site. Welcome!

Bonsai is a graphics library which includes an intuitive graphics API and an SVG renderer.

What does Bonsai look like?

<!--runnable-->
{% highlight javascript %}
var square = Shape.rect(0, 0, 100, 100);

square.addTo(stage);
square.attr('fillColor', 'red');
square.animate('1.5s', {
  origin: [50, 50],
  rotation: Math.PI * 1,
  x: 700,
  fillColor: 'green'
});
{% endhighlight %}

