---
title: Simple Shapes
layout: doc
---

Within Bonsai's path module are a selection of shape classes. Note that these are globally exposed and inherit from the `Path` class.

 * `new Rect(x, y, width, height, [cornerRadius])` ([docs](/module-path.Rect.html))
 * `new Arc(x, y, radius, startAngle, endAngle, isAntiClockwise)` ([docs](/module-path.Arc.html))
 * `new Circle(x, y, radius)` ([docs](/module-path.Circle.html))
 * `new Ellipse(centerX, centerY, radiusX, radiusY)` ([docs](/module-path.Ellipse.html))
 * `new Polygon(x, y, radius, sides)` ([docs](/module-path.Polygon.html))
 * `new Star(x, y, radius, rays, factor)` ([docs](/module-path.Star.html))


<!--runnable-->
{% highlight javascript %}
var myShape = new Rect(10, 10, 100, 100);

myShape.fill('yellow');
myShape.line('#f00', 2);
myShape.addTo(stage);
{% endhighlight %}

For a more detailed overview and more details about the path module see the [Paths Overview](/overview/Path.html) and the [Path Module Documentation](/module-path.html).
