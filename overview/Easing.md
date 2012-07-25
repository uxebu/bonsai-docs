---
title: Easing
layout: doc
---

<style>
#easing_functions {
  line-height: 2em;
}
#easing_functions a {
  padding: 3px 5px;
  background: #EEE;
  font-weight: 700;
  cursor: pointer;
  color: #000;
  text-decoration: none;
  box-shadow: 0 0 3px #000;
}
#easing_functions a:hover, #easing_functions a:focus, #easing_functions a.active {
  background: #000;
  color: #FFF;
}
</style>

Bonsai's animations can utilise one of many easing functions. Usually, the easing
function's name will be passed as an option, like so:

{% highlight javascript %}
myDisplayObject.animate('650ms', {
  x: 100,
  y: 900
}, {
  easing: 'bounceIn'
})
{% endhighlight %}

### Try it out

<script>

$(document).ready(function() {

  var code = "new Circle(150, 50, 30)\n  .fill('red')\n  .fill(gradient.radial(['rgba(0,0,0,0)', 'rgba(0,0,0,0.3)']))\n  .addTo(stage)\n  ";

  window.runnableEasing = new doc.Runnable({ height: 100, width: 700 });

  runnableEasing.dom.insertAfter('h3:first');

  function setEasing(easing) {
    runnableEasing.setEditableCode(code + ".animate('1s', { x: 500 }, { easing: '"+easing+"' });");
    runnableEasing.run();
  }

  var easingAnchors = $('#easing_functions a').attr('href', 'javascript:void 0;').click(function() {
    setEasing($(this).text());
    easingAnchors.removeClass('active');
    $(this).addClass('active');
  });

  easingAnchors.first().click();

});

</script>

<p id="easing_functions">
  <a>linear</a>
  <a>quadIn</a>
  <a>quadOut</a>
  <a>quadInOut</a>
  <a>cubicIn</a>
  <a>cubicOut</a>
  <a>cubicInOut</a>
  <a>quartIn</a>
  <a>quartOut</a>
  <a>quartInOut</a>
  <a>quintIn</a>
  <a>quintOut</a>
  <a>quintInOut</a>
  <a>sineIn</a>
  <a>sineOut</a>
  <a>sineInOut</a>
  <a>expoIn</a>
  <a>expoOut</a>
  <a>expoInOut</a>
  <a>circIn</a>
  <a>circOut</a>
  <a>circInOut</a>
  <a>backIn</a>
  <a>backOut</a>
  <a>backInOut</a>
  <a>elasticIn</a>
  <a>elasticOut</a>
  <a>elasticInOut</a>
  <a>bounceIn</a>
  <a>bounceOut</a>
  <a>bounceInOut</a>
</p>
