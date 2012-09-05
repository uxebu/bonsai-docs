---
title: Performance concerns
layout: doc
---

We've identified the following performance concerns in Bonsai using the default SVG renderer:

 * On iOS devices, applying multiple fill styles (e.g. a color and a gradient) is expensive, as a unique `<pattern>` has to be made for each fill combination. It's best to avoid this by applying the entire fill using a single style (color, gradient, image) instead of combining them. See [this demo](http://demos.bonsaijs.org/demos/circles/index.html) for an example of the issue.
 * On iOS devices, animating many objects at once causes a noticable slowdown. See [this demo](http://demos.bonsaijs.org/demos/rainbow/index.html) for an example.