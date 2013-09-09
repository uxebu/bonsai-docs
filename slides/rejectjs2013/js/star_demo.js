x = 250;
y = 250;

var dark = true;
var hue = 0;

function make() {

  hue = hue + .005 > 1 ? 0 : hue + .005; // vary hue slightly with each star
  var baseColor = color('red').hue(hue);
  var c = dark ? baseColor.darker(.2) : baseColor.lighter(.3);
  dark = !dark;

  var s = new Star(x, y, 150, 5, 0).fill(c).addTo(stage);

  s.animate('3s', {
    factor: 2,
    rotation: Math.PI / 5
  }, {
    easing: 'sineInOut',
    onEnd: function() {
      s.remove();
    }
  });

}

stage.on('tick', function(e, f) {
  if (f % 4 === 0) { // every fourth frame
    make();
  }
});
