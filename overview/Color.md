---
title: Color
layout: doc
---

### Playground:

<!--runnable-->
{% highlight javascript %}
var myHue = color('hsl(0,100%,50%)');
var rows = 6, cols = 30, steps = cols * rows;

for (var r = 0; r < rows; ++r) {
  for (var c = 0; c < cols; ++c) {
    Shape.rect(c*20, r*20, 20, 20)
      // Increment hue slightly with each step:
      .addTo(stage).attr('fillColor', myHue.hue(myHue.hue() + 1/steps));
  }
}
{% endhighlight %}

### Intro

Bonsai provides a helpful color API. With it you can parse and manipulate colors. To parse a color and get a fresh `color.RGBAColor` instance, simply call:

{% highlight javascript %}
color('red');
{% endhighlight %}

This gives you a `color.RGBAColor` instance.

An `RGBAColor` instance allows you to set and get the `r`, `g`, `b` and `a` values of the color, in addition to `h` (hue), `s` (saturation) and `l` (lightness) values.

**NOTE: `r`, `g` and `b` are `0..255`, while `h`, `s`, `l` and `a` (alpha) are `0..1`.**

E.g.

{% highlight javascript %}
var myColor = color('red'); // or `new color.RGBAColor(255,0,0)`
myColor.hue(0.5); // change to cyan
{% endhighlight %}

You can also use the more verbose `set` and `get` methods:

{% highlight javascript %}
myColor.set('hue', 0.5);
myColor.set('green', 255);
{% endhighlight %}

For getting string representations of colors, `RGBAColor` implements three methods:

* `.rgba()`: outputs `"rgba(r,g,b,a)"`
* `.rgb()`: outputs `"rgb(r,g,b)"`
* `.hsla()`: outputs `"hsla(h,s,l,a)"`

## Color spawning methods

The `color.RGBAColor` class contains a number of color-spawning methods, i.e. methods that return various colors, mostly variations of the instance color:

{% highlight javascript %}
var myColor = new color.RGBAColor('red');

myColor.lighter();      // -> color with lightness increased by 0.01
myColor.lighter(.2);    // -> color with lightness increased by 0.2
myColor.darker()        // -> color with lightness decreased by 0.01
myColor.lighter(.2);    // -> color with lightness decreased by 0.2
myColor.midpoint(x);    // -> color between `color` and `x`
{% endhighlight %}

Example usage of `midpoint`:

{% highlight javascript %}
color('red').midpoint('white'); // -> pink
{% endhighlight %}

There is also a generic `randomize` method which accepts two arguments, a string or array specifying propert(y|ies) to randomize and a `range` argument to specify to what degree they should be randomized. Both arguments are optional though:

{% highlight javascript %}
myColor.randomize(); // -> default is randomizing by 'r', 'g', and 'b' (100% random color)
{% endhighlight %}

Examples using the available arguments:

{% highlight javascript %}
color('red').randomize('hue'); // -> randomize by hue, leaving saturation/lightness as-is
{% endhighlight %}

Available properties to animate include: `hue`, `saturation`, `lightness`, `alpha`, `red`, `green`, `blue` (aliases work too, `h`, `s`, `l`, `a`, `r`, `g`, `b`...)

The range argument, if passed, will ensure the randomization occurs around the current value. So, if you wanted to randomize by `hue` (which can be from `0` to `1`), but you only wanted a slight change from the current value, you could do this:

{% highlight javascript %}
color('yellow').randomize('hue', 0.2);
{% endhighlight %}

The `hue` of yellow is `0.16` (or 60 degrees). Passing a range of `0.2` will ensure that the random `hue` produced is no smaller than `0.06` and no bigger than `0.26` (i.e. `0.1` in each direction from the original hue, a full range of `0.2`).

### `color.parse`: {#color_parse}

Internally we are using a 32-bit number to represent colors (including alpha). The format is:

{% highlight javascript %}
0x<rr><gg><bb><aa>
{% endhighlight %}

*i.e. the first eight bits are red, the second eight bits are green ...*

The `color.parse` function can accept any of the following formats:

* **hex** (e.g. `#FFF` or `#FFFFFF`)
* **hex** *with alpha* (e.g. `#112233FF`)
* **rgba** (e.g. `rgba(255,255,255,1)`)
* **rgb** (e.g. `rgb(255,255,255)`)
* **hsla** (e.g. `hsla(180,50%,50%,0.5)`)
* **hsl** (e.g. `hsl(180,50%,50%)`)
* **Named colors** (e.g. `yellow`, `red`) - *specified in `color_map.js`*
* **Numerical 32-bit representation** (`0x<rr><gg><bb><aa>`)

*Where alpha isn't specified, it is assumed to be `1`.*

So, `color.parse` just returns a number:

{% highlight javascript %}
color.parse('red'); // 0xff0000ff
{% endhighlight %}
