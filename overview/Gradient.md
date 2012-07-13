---
title: Gradient
layout: doc
---

Bonsai provides four factories for making linear or radial gradients:

 * [`gradient.linear`](/module-gradient.html#linear)
 * [`gradient.radial`](/module-gradient.html#radial)
 * [`gradient.advancedLinear`](/module-gradient.html#advancedLinear)
 * [`gradient.advancedRadial`](/module-gradient.html#advancedRadial)

### Try it out:

<!--runnable-->
{% highlight javascript %}
var s = Shape.rect(0, 0, 200, 100);
s.addTo(stage);
s.attr(
  'fillGradient',
  gradient.linear('top right', ['red', ['yellow', 80], 'blue'])
);
{% endhighlight %}

