---
title: Animation
layout: doc
---

Bonsai provides an `Animation` class, a `KeyframeAnimation` class and a convenience `animate` method on all `DisplayObject` instances.

Animating a red square to be blue, for example, is as simple as:

### Try it out:

<!--runnable-->
{% highlight javascript %}
Shape.rect(0, 0, 100, 100)
  .addTo(stage)
  .attr('fillColor', 'red')
  .animate('1s', {
    fillColor: 'blue'
  });
{% endhighlight %}

### The `animate` method

The `animate` method accepts three arguments:

```
animate(duration, properties[, options])
```

 * `duration` -- The animation duration. Acceptable formats:
  * Seconds: A string ending in `"s"` (e.g. `"2s"`)
  * Milliseconds: A string ending in `"ms"` (e.g. `"200ms"`)
  * Frames: A number (e.g. `30`)
  * Percent of movie: A string ending in `"%"`. Note this will only work if the root timeline (typically the `stage`) has a defined frame length.
 * `properties` (*`Object`*) -- The properties you'd like to animate, as a map: `{ propertyName: valueToAnimateTo }`.
 * `options` (*`Object`*) -- Any additional options:
  * `easing` (*`String`*) -- one of the easing function name
  * `repeat` (*`Number`*) -- how many times you want the animation to repeat
