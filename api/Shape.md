---
title: Shape
layout: doc
---

### Try it out:

<!--runnable-->
{% highlight javascript %}
var a = Shape.circle(100, -50, 50);
a.attr('fillColor', 'lightblue').addTo(stage);

a.animate('1s', {
  scale: 1.5,
  fillColor: 'darkblue',
  y: 100
}, { easing: 'bounceOut' });
{% endhighlight %}

### Shape constructor

The Shape constructor accepts three different argument signatures:

#### String: SVG path

A `String` with space/comma separated path commands, as per the [SVG Path spec](http://www.w3.org/TR/SVG/paths.html):

{% highlight javascript %}
new Shape('l 100,0 l 0,100 l -100,0 l 0,-100');
{% endhighlight %}

#### Array: Path commands

An `Array` of arrays, each sub-array consistening of a command (e.g. `lineTo`) and its arguments:

{% highlight javascript %}
new Shape([
  ['moveTo', 0, 0],
  ['lineBy', 100, 0],
  ['lineBy', 0, 100],
  ['lineBy', -100, 0],
  ['lineBy', 0, -100]
]);
{% endhighlight %}

#### Array: Points of polygon

The `x` and `y` position of each point. Each coordinate takes up two array slots:

{% highlight javascript %}
new Shape([
  0, 0,
  100, 0,
  100, 100,
  0, 100
]);
{% endhighlight %}

### Factories/Helpers

For the simpler shapes bonsai provides convenience factories:

 * `Shape.rect(x, y, width, height, [cornerRadius])`
 * `Shape.arc(x, y, radius, startAngle, endAngle, isAntiClockwise)`
 * `Shape.circle(x, y, radius)`
 * `Shape.ellipse(centerX, centerY, radiusX, radiusY)`
 * `Shape.polygon(x, y, radius, sides)`
 * `Shape.star(x, y, radius, rays, factor)`

