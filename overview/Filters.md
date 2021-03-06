---
title: Filters
layout: doc
---

Bonsai provides a number of filters which can be applied to Shapes, Bitmaps and Text. Here's en example of the blur filter being used

### Example

Here's an example of applying a DropShadow filter to a circle shape:

<!--runnable-->
{% highlight javascript %}
new Circle(50, 50, 30).addTo(stage)
  .fill(gradient.linear(0, ['red', 'yellow']))
  .attr('filters', new filter.DropShadow(1, 1, 5, 0x000000FF));
{% endhighlight %}

### Available filters

 * [filter.BaseFilter](/module-filter.filter.BaseFilter.html)
 * [filter.Blur](/module-filter.filter.Blur.html)
 * [filter.Brightness](/module-filter.filter.Brightness.html)
 * [filter.ColorMatrix](/module-filter.filter.ColorMatrix.html)
 * [filter.Contrast](/module-filter.filter.Contrast.html)
 * [filter.DropShadow](/module-filter.filter.DropShadow.html)
 * [filter.Grayscale](/module-filter.filter.Grayscale.html)
 * [filter.HueRotate](/module-filter.filter.HueRotate.html)
 * [filter.Invert](/module-filter.filter.Invert.html)
 * [filter.Opacity](/module-filter.filter.Opacity.html)
 * [filter.Saturate](/module-filter.filter.Saturate.html)
 * [filter.Sepia](/module-filter.filter.Sepia.html)

See the [filter module &raquo;](/module-filter.html)


### Remove filters

To remove filters from an object, you need to set the `filters` attribute to `null`:

{% highlight javascript %}
thing.attr('filters', null);
{% endhighlight %}

To remove individual filters you'll want to retrieve the filters array (`thing.attr('filters')`)
and then mutate as you wish, and then re-set filters, with `thing.attr('filters', ...)`.

For example, here I add two filters (blur and saturate) and then remove the second one:

{% highlight javascript %}
var c = new Circle(50, 50, 30).addTo(stage);

// Add blur and saturate
c.attr(
  'filters',
  [filter.blur(4), filter.saturate(5)]
);

// Re-set filters, but this time JUST the blur filter
// (removing the saturate filter)
c.attr(
  'filters',
  c.attr('filters').slice(0, 1)
);
{% endhighlight %}