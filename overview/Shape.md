---
title: Shape
layout: doc
---

### Try it out:

<!--runnable-->
{% highlight javascript %}
var a = Shape.circle(100, -50, 50).fill('lightblue').addTo(stage);

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

### Applying a fill to a shape {#filling}

Shape instances support the following fill attributes:

 * fillColor: A [`color.RGBAColor`](/module-color.RGBAColor.html) instance or anything that can be parsed by [`color.parse`](/overview/Color.html#color_parse).
 * fillGradient: A [`gradient.LinearGradient`](/module-gradient.LinearGradient.html) or [`gradient.RadialGradient`](/module-gradient.RadialGradient.html) instance. See [the Gradient overview](/overview/Gradient.html) for more details on how to create gradients.
 * fillImage: A [`Bitmap`](/Bitmap.html) instance.

The quickest way to fill a shape is via the [`fill` method](/Shape.html#fill):

<!--runnable-->
{% highlight javascript %}
var s = Shape.circle(50, 50, 50);
s.fill('red').addTo(stage);

// You can add a fillGradient on top of a fillColor too:
s.fill(gradient.linear(0, ['white', 'transparent']))
{% endhighlight %}

### Applying a line to a Shape {#stroking}

Shape instances support the following line attributes:

 * lineWidth: A number (pixel width)
 * lineColor: A [`color.RGBAColor`](/module-color.RGBAColor.html) instance or anything that can be parsed by [`color.parse`](/overview/Color.html#color_parse).
 * lineGradient: A [`gradient.LinearGradient`](/module-gradient.LinearGradient.html) or [`gradient.RadialGradient`](/module-gradient.RadialGradient.html) instance. See [the Gradient overview](/overview/Gradient.html) for more details on how to create gradients.

The quickest way to apply a line to a shape is via the [`line` method](/Shape.html#line):

<!--runnable-->
{% highlight javascript %}
Shape.circle(50, 50, 50)
  .line('red', 5)
  .addTo(stage);
{% endhighlight %}




