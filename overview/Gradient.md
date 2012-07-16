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

### Sample gradients {#samples}

<script><!--

$(document).ready(function() {

  var samples = $('<div/>').insertAfter('#samples');

  var gradients = [
    "gradient.linear(0, ['red', 'yellow'])",
    "gradient.linear(90, ['red', 'yellow'])",
    "gradient.linear(90, ['red', 'yellow'], 5)",
    "gradient.linear(90, ['red', 'yellow', 'red'], 5)",
    "gradient.radial(['yellow', 'red'])",
    "gradient.radial(['yellow', 'red'], 100, 0, 50)",
  ];

  for (var i = 0, l = gradients.length; i < l; ++i) {
    var runnable = new doc.Runnable({ height: 100, width: 340 });
    runnable.setEditableCode("Shape.rect(0, 0, 340, 100)\n  .attr(\n    'fillGradient',\n    " + gradients[i] + "\n  )\n  .addTo(stage);");
    runnable.dom.appendTo(samples);
    runnable.dom.width(340).css({
      'float': 'left',
      'margin': '0 8px 8px 0'
    });
    runnable.dom.editor.code.css('fontSize', '.7em');
    runnable.run();
  }

});

--></script>
