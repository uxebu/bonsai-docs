---
title: Paths
layout: doc
---

Bonsai provides a generic `Path` class for you to create arbitrary paths:

E.g.

<!--runnable-->
{% highlight javascript %}
new Path()
  .moveTo(0, 0)
  .lineTo(100, 100)
  .lineTo(0, 100)
  .closePath()
  .fill('blue')
  .addTo(stage);
{% endhighlight %}

### Path constructor

The Path constructor accepts three different argument signatures:

#### String: SVG path

A `String` with space/comma separated path commands, as per the [SVG Path spec](http://www.w3.org/TR/SVG/paths.html):

{% highlight javascript %}
new Path('l 100,0 l 0,100 l -100,0 l 0,-100');
{% endhighlight %}

#### Array: Path commands

An `Array` of arrays, each sub-array consistening of a command (e.g. `lineTo`) and its arguments:

{% highlight javascript %}
new Path([
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
new Path([
  0, 0,
  100, 0,
  100, 100,
  0, 100
]);
{% endhighlight %}

### Path special classes

Within Bonsai's path module are a selection of shape classes. Note that these are globally exposed and inherit from the `Path` class.

 * `new Rect(x, y, width, height, [cornerRadius])` ([docs](/module-path.Rect.html))
 * `new Arc(x, y, radius, startAngle, endAngle, isAntiClockwise)` ([docs](/module-path.Arc.html))
 * `new Circle(x, y, radius)` ([docs](/module-path.Circle.html))
 * `new Ellipse(centerX, centerY, radiusX, radiusY)` ([docs](/module-path.Ellipse.html))
 * `new Polygon(x, y, radius, sides)` ([docs](/module-path.Polygon.html))
 * `new Star(x, y, radius, rays, factor)` ([docs](/module-path.Star.html))

### Applying a fill to a shape {#filling}

Path instances support the following fill attributes:

 * `fillColor`: A [`color.RGBAColor`](/module-color.RGBAColor.html) instance or anything that can be parsed by [`color.parse`](/overview/Color.html#color_parse).
 * `fillGradient`: A [`gradient.LinearGradient`](/module-gradient.LinearGradient.html) or [`gradient.RadialGradient`](/module-gradient.RadialGradient.html) instance. See [the Gradient overview](/overview/Gradient.html) for more details on how to create gradients.
 * `fillImage`: A [`Bitmap`](/Bitmap.html) instance.

The quickest way to fill a shape is via the [`fill` method](/module-path.Path.html#fill):

<!--runnable-->
{% highlight javascript %}
var c = new Circle(50, 50, 50);
c.fill('red').addTo(stage);

// You can add a fillGradient on top of a fillColor too:
c.fill(gradient.linear(0, ['white', 'transparent']));
{% endhighlight %}

### Applying a line to a Path {#stroking}

Path instances support the following line attributes:

 * `strokeWidth`: A number (pixel width)
 * `strokeColor`: A [`color.RGBAColor`](/module-color.RGBAColor.html) instance or anything that can be parsed by [`color.parse`](/overview/Color.html#color_parse).
 * `strokeGradient`: A [`gradient.LinearGradient`](/module-gradient.LinearGradient.html) or [`gradient.RadialGradient`](/module-gradient.RadialGradient.html) instance. See [the Gradient overview](/overview/Gradient.html) for more details on how to create gradients.

The quickest way to apply a line to a shape is via the [`line` method](/module-path.Path.html#line):

<!--runnable-->
{% highlight javascript %}
new Circle(60, 60, 50)
  .stroke('red', 5)
  .addTo(stage);
{% endhighlight %}




