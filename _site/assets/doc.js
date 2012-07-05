 var doc = {

  init: function() {
    doc.forEachRunnableCodeBlock(doc.makeRunnable);
  },

  /**
   * Gathers aggregate text of node
   */
  _innerText: function(node) {
    if (node.nodeType === 3) {
      return node.data;
    }
    var txt = '';
    if (node = node.firstChild) do {
      txt += doc._innerText(node);
    } while (node = node.nextSibling);
    return txt;
  },

  forEachRunnableCodeBlock: function(fn) {
    $('div.highlight').each(function(i, block) {
      if (block.previousSibling.nodeType === 8 && block.previousSibling.data === 'runnable') {
        fn(block, doc._innerText(block));
      }
    });
  },

  makeRunnable: function(block, code) {

    block = $(block);

    var height = Math.max(200, block.height()),
        width = 700;

    var dom = $('<div class=runner />');
    dom.nav = $('<div class=nav />').appendTo(dom);
    dom.nav.edit = $('<a href="javascript:void 0">edit</a>').appendTo(dom.nav);
    dom.nav.run = $('<a href="javascript:void 0">run</a>').appendTo(dom.nav);
    dom.editor = $('<div class=editor />').appendTo(dom);
    dom.stage = $('<div class=stage />').appendTo(dom);
    dom.insertBefore(block);
    block.appendTo(dom.editor);

    block.removeClass('highlight');

    block.css({ width: width, height: height });
    dom.editor.css({ width: width, height: height });
    dom.stage.css({ width: width, height: height });

    var aceEditor = ace.edit(block[0]);
    aceEditor.session.setMode("ace/mode/javascript");
    aceEditor.getSession().setTabSize(2);
    aceEditor.getSession().setUseSoftTabs(true);

    var bonsaiPlayer;

    // Bind buttons:

    dom.nav.edit.click(function() {
      dom.nav.edit.addClass('active');
      dom.nav.run.removeClass('active');
      dom.stage.hide();
      dom.editor.show();
    });
    dom.nav.run.click(function() {
      dom.nav.edit.removeClass('active');
      dom.nav.run.addClass('active');
      dom.stage.show();
      dom.editor.hide();
      bonsaiPlayer && bonsaiPlayer.destroy();
      bonsaiPlayer = bonsai.run(dom.stage[0], {
        height: height,
        width: width,
        code: aceEditor.getSession().getValue(),
        framerate: 40
      });
    });
    dom.nav.edit.click();

  }

 };
