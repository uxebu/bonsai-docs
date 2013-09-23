function Tracker(path) {
  this.trackee = path;
  this.group = new Group().addTo(path.parent);
  this.box = new Rect(0, 0, 598, 598).addTo(this.group);
  this.vert1 = new Path()
      .addTo(this.group).moveTo(0, 0).lineTo(0, 1000).stroke('#262C35', 1);
  this.vert2 = new Path()
      .addTo(this.group).moveTo(0, 0).lineTo(0, 1000).stroke('#262C35', 1);
  this.horz1 = new Path()
      .addTo(this.group).moveTo(0, 0).lineTo(1000, 0).stroke('#262C35', 1);
  this.horz2 = new Path()
      .addTo(this.group).moveTo(0, 0).lineTo(1000, 0).stroke('#262C35', 1);
  stage.on('tick', this, this.track);
}

Tracker.prototype = {
  track: function() {
    var box = this.trackee.getBoundingBox( this.trackee.attr('matrix') );
    this.vert1.attr('x', box.left);
    this.vert2.attr('x', box.right);
    this.horz1.attr('y', box.top);
    this.horz2.attr('y', box.bottom);
  }
};

var star = Path.star(100, 100, 50, 5, 3).attr('filters', [
    filter.DropShadow(1, 1, 1, 'grey')
  ]);
// new Star(x, y, radius, rays, factor)
var morphStar = new Star(10, 10, 50, 5, 3);

star.fill('yellow');
star.addTo(stage);
new Tracker(star);

anim();

function anim() {
  morphStar.attr({
      x: Math.random() * 100 + 200,
      y: Math.random() * 100 + 200,
      radius: Math.random() * 50 + 30,
      rays: 0 | Math.random() * 5 + 5,
      factor: Math.random() * 3 + 0.2
  });
  star.morphTo(morphStar.fill('random').attr('filters', [
    filter.DropShadow(Math.random() * 15, Math.random() * 15, Math.random() * 30,'grey')
  ]).attr('rotation', Math.random() * Math.PI*2),
    '3s',
    {
      onEnd: anim,
      easing: 'sineInOut'
    }
  );
}
