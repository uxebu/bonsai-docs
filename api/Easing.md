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

### Try it out

<script>

var prepCode = "something = Shape.circle(150, 50, 30).attr({fillColor:'red', fillGradient: gradient.radial(['rgba(0,0,0,0)', 'rgba(0,0,0,0.3)'])}).addTo(stage);";

var runnable = new doc.Runnable({ height: 100, width: 700 });

runnable.dom.insertAfter('h3:first');
runnable.setPrepCode(prepCode);

function setEasing(easing) {
  runnable.setEditableCode("something.animate('1s', { x: 500 }, { easing: '"+easing+"' });");
  runnable.run();
}

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

<script>
var easingAnchors = $('#easing_functions a').attr('href', 'javascript:void 0;').click(function() {
  setEasing($(this).text());
  easingAnchors.removeClass('active');
  $(this).addClass('active');
});

easingAnchors.first().click();
</script>