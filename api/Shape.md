---
title: Shape
layout: doc
---

Bonsai's `new Shape()` constructor is used to create complex shapes by specifying every path segment used. For example, a simple square (`100x100 @ {0,0}`) would be:

{% highlight javascript %}
new Shape('l 100,0 l 0,100 l -100,0 l 0,-100');
{% endhighlight %}

Don't worry though. For the simpler shapes bonsai provides convenience factories:

 * `Shape.rect(x, y, width, height, [cornerRadius])`
 * `Shape.arc(x, y, radius, startAngle, endAngle, isAntiClockwise)`
 * `Shape.circle(x, y, radius)`
 * `Shape.ellipse(centerX, centerY, radiusX, radiusY)`
 * `Shape.polygon(x, y, radius, sides)`
 * `Shape.star(x, y, radius, rays, factor)`

### 101: Add a red square (`100x100 @ {0,0}`) to the stage

{% highlight javascript %}
Shape.rect(0, 0, 100, 100).attr('fillColor', 'red').addTo(stage);
{% endhighlight %}