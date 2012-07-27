---
title: Groups
layout: doc
---

Bonsai provides a `Group` class which can be used to create hierarchical structures in your stage. A group can be added any `DisplayList` (stage, sub-movies, other groups) and be be transformed like any other `DisplayObject`.

### An example:

Here we're creating a group and filling it with 100 smaller DisplayObjects and then we're animating the position of the entire group.

<!--runnable:{height:300}-->
{% highlight javascript %}
var container = new Group().addTo(stage);

for (var r = 0; r < 10; ++r) {
  for (var c = 0; c < 10; ++c) {
    new Rect(c*10, r*10, 10, 10).addTo(container).fill('random');
  }
}

function anim() {
  // Move the container to random locations
  container.animate('1s', {
    x: Math.random() * 500, y: Math.random() * 200
  }, {
    onEnd: anim, easing: 'elasticInOut'
  });
}

anim();
{% endhighlight %}

[See `Group` API Documentation](/Group.html)