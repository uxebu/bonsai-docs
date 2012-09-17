---
title: Events
layout: doc
---

Bonsai supports a number of events.

To bind an event listener to a Bonsai object use the mixin'd [EventEmitter](/EventEmitter.html) methods:

<!--runnable-->
{% highlight javascript %}
new Circle(50, 50, 30).addTo(stage)
  .fill('red')
  .on('pointermove', function(e) {
    this.fill('random');
  });
{% endhighlight %}

### Pointer Events

Bonsai's DisplayObjects support the following pointer events:

 * `pointerup`: fires on a single-finger touchend event or a mouseup event.
 * `pointerdown`: fires on a single-finger touchstart event or a mousedown event.
 * `pointermove`: fires on a single-finger touchmove event or a mousemove event.
 * `click`: fires on a single-finder touchstart-touchend cycle (no mediating touchmove) or a click event.
 * `doubleclick`: fires on a dblclick event.
 * `drag`: fires on subsequent pointermove events after a pointerdown event.

All pointer events will include the following properties in the passed Event object which is passed to your event handlers:

 * `x`or `stageX`: X coordinate of the pointer event within the stage
 * `y`or `stageY`: X coordinate of the pointer event within the stage
 * `clientX`: X coordinate of the pointer event within the parent window
 * `clientY`: Y coordinate of the pointer event within the parent window 

### Touch Events

By default, you can bind the above pointer events and they should work as you would
for single-finger interactions.

For multitiple-finger interactions, you should bind to the following prefixxed events:

 * `multi:pointerup`
 * `multi:pointerdown`
 * `multi:pointermove`
 * `multi:drag`

All `multi:` events will have a `touchId` in the passed event object, so you can
keep track of the fingers currently on screen. i.e.

{% highlight javascript %}
stage.on('multi:pointerdown', function(e) {
  e.touchId; // unique identifier for the current finger
});
{% endhighlight %}

### Key Events

The stage object supports key events:

 * `key`: (analogous to `keypress` in the DOM)
 * `keydown`
 * `keyup`

All key events will include the following properties in the passed Event object which is passed to your event handlers:

 * `event.keyCode`
 * `event.ctrlKey`
 * `event.altKey`
 * `event.metaKey`
 * `event.shiftKey`

E.g.

{% highlight javascript %}
stage.on('key', function(e) {
  console.log('Key event: ' + e.keyCode);
});
{% endhighlight %}

### Meta Events

DisplayObjects emit the following meta events:

 * `removedFromStage`
 * `addedToStage`

