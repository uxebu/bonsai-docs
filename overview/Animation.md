---
title: Animation
layout: doc
---

Bonsai provides an `Animation` class, a `KeyframeAnimation` class and a convenience `animate` method on all `DisplayObject` instances.

Animating a red square to be blue, for example, is as simple as:

### Try it out:

<!--runnable-->
{% highlight javascript %}
new Rect(0, 0, 100, 100)
  .addTo(stage)
  .attr('fillColor', 'red')
  .animate('1s', {
    fillColor: 'blue'
  });
{% endhighlight %}

### The `animate` method

The [`animate` method](/DisplayObject.html#animate) is available on all DisplayObjects and acts as a shortcut. An animation utilising all available options might look like this:

{% highlight javascript %}
myDisplayObject.animate('650ms', {
  x: 100,
  y: 900
}, {
  easing: 'bounceIn',
  delay: '200ms'
})
{% endhighlight %}

This'll apply easing to the animation and a delay of 200 milliseconds before the animation begins.

### Animation options

Options are passed as the third argument to `new Animation`, `new KeyframeAnimation` or
`DisplayObject#animate`:

 * `easing` (String) -- one of the easing function name (see the [easing overview](/overview/Easing.html))
 * `repeat` (Number) -- how many times you want the animation to repeat
 * `subjects` (Object|Array) -- Additional subjects to apply the animation to
 * `delay` (Number|String) -- How long to delay the animation (seconds, milliseconds, frames or percent)
 * `isTimelineBound` (Boolean) -- Whether the animation should respond to the stage's `isPlaying` state (default is `true`).

### Acceptable duration/delay

 * Seconds: A string ending in `"s"` (e.g. `"2s"`)
 * Milliseconds: A string ending in `"ms"` (e.g. `"200ms"`)
 * Frames: A number (e.g. `30`)
 * Percent of movie: A string ending in `"%"`. Note this will only work if the root timeline (typically the `stage`) has a defined frame length.

### Animation class

For even more control you can create an `Animation` instance yourself.

A simple animation:

{% highlight javascript %}
var myAnimation = new Animation('1s', {
  x: 190 // animate `x` attribute to 190
});

myDisplayObject.animate(myAnimation); // apply myAnimation to `myDisplayObject`
{% endhighlight %}

Passing an `Animation` instance to `DisplayObject.prototype.animate` will automatically
initiate it with that DisplayObject as the subject of the animation. An animation
can have multiple subjects, and you can set them manually. For example:

<!--runnable-->
{% highlight javascript %}
var myShapeA = new Rect(0, 0, 50, 50).addTo(stage).attr('fillColor', 'red');
var myShapeB = new Rect(0, 50, 50, 50).addTo(stage).attr('fillColor', 'blue');
var myAnimation = new Animation('1s', {
  x: 100,
  fillColor: 'green'
});
myAnimation.addSubjects([myShapeA, myShapeB]);
myAnimation.play();
{% endhighlight %}

For convenience you can pass all subjects directly to the `play` method too:

{% highlight javascript %}
myAnimation.play([myShapeA, myShapeB]);
{% endhighlight %}

### Non numeric animations

Most values you animate will inevitably be single numeric values, like `x` or `scaleY`.
For when you want to animate more unique values, such as a gradient or color, the `Animation`
class will automatically translate these values and mutate the real attribute appropriately.
The following unique attributes can be animated in bonsai:

 * `fillColor`
 * `strokeColor`
 * `fillGradient`
 * `strokeGradient`
 * `filter`
 * `segments`

If you try to animate a color, like this:

{% highlight javascript %}
thing.animate('1s', { fillColor: 'red' });
{% endhighlight %}

The `Animation` class will grab the current `fillColor` attribute, and then will determine
its R, G, B, and A values. It'll then animate each of these values individually to reach
the targetted R, G, B and A values in the color that you're animating to (in this case: red).

### Keyframe Animations

Bonsai has a [`KeyframeAnimation` class](/module-animation.KeyframeAnimation.html) which is designed to provide you with an easy way
to set up a series of consecutive animations. For example, if I wanted to animate a shape
from `{0,0}` to `{100,100}` and then back to `{0,0}`, without KeyframeAnimation, I would do this:

{% highlight javascript %}
thing.attr({x:0, y:0}).animate('1s', {
  x: 100,
  y: 100
}, {
  onEnd: function() {
    thing.animate('1s', {
      x: 0,
      y: 0
    })
  }
});
{% endhighlight %}

Fortunately, though, bonsai *does* provide keyframe animations so you can simply
do:

{% highlight javascript %}
thing.animate(new KeyframeAnimation('2s', {
  '0%': { x: 0, y: 0 },
  '50%': { x: 100, y: 100 },
  '100%': { x: 0, y: 0 }
}));
{% endhighlight %}

The keywords, `"from"` and `"start"` are synonymous with `0%`, and `"to"` and `"end"` are
synonymous with `100%` so the above could also be written as:

{% highlight javascript %}
thing.animate(new KeyframeAnimation('2s', {
  from: { x: 0, y: 0 },
  '50%': { x: 100, y: 100 },
  to: { x: 0, y: 0 }
}));
{% endhighlight %}

The key part of the animation definitions (`to`, `from`, `50%`, etc.) can be defined
in a number of ways:

 * keywords (from, to, start, end)
 * percent of total keyframe animation (e.g. `35%`)
 * seconds (e.g. `1s`)
 * milliseconds (e.g. `400ms`)
 * frames (e.g. `30` -- same as `1s` @ 30FPS)

The `KeyframeAnimation` class will automatically fill any undefined properties at
half-way points in your animation series. See the code below:

{% highlight javascript %}
new KeyframeAnimation('1s', {
   '0s' : { x: 0, y: 0 },
  '.5s' : { x: 50, y: 50 },
   '1s' : { x: 150, y: 100 }
});
{% endhighlight %}

You can omit the `y` property in the `.5s` keyframe because KeyframeAnimation will
automatically calculate the halfways point between its `0s` value (0) and its `1s`
value (100):

{% highlight javascript %}
new KeyframeAnimation('1.5s', {
   '0s' : { x: 0, y: 0 },
  '.5s' : { x: 50 },
   '1s' : { x: 150, y: 100 }
});
{% endhighlight %}

