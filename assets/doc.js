 var doc = {

  init: function() {
    // Create runnable blocks:
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
      var data = block.previousSibling.data;
      if (block.previousSibling.nodeType === 8 && /^runnable/.test(data)) {
        if (/^runnable:\{/.test(data)) {
          var extraOptions = Function('return ' + data.substring(9))();
        }
        fn(block, doc._innerText(block), extraOptions || {});
      }
    });
  },

  makeRunnable: function(block, code, options) {

    block = $(block);

    options.height = options.height || Math.max(130, block.outerHeight());
    options.width = options.width || 700;

    var r = new doc.Runnable(options);
    r.setEditableCode(code);
    r.dom.insertAfter(block);
    block.remove();

  },

  Runnable: function(options) {

    var height = options.height,
        width = options.width;

    var prepCode = options.prepCode;

    var dom = this.dom = $('<div class=runner />');
    dom.nav = $('<div class=nav />').appendTo(dom);
    dom.nav.edit = $('<a href="javascript:void 0">edit</a>').appendTo(dom.nav);
    dom.nav.run = $('<a href="javascript:void 0">run</a>').appendTo(dom.nav);
    dom.editor = $('<div class=editor />').appendTo(dom);
    dom.editor.code = $('<div class=editor_code />').appendTo(dom.editor);
    dom.stage = $('<div class=stage />').appendTo(dom);

    dom.editor.code.css({ width: width, height: height });
    dom.editor.css({ width: width, height: height });
    dom.stage.css({ width: width, height: height });

    var aceEditor = ace.edit(dom.editor.code[0]);
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
      // Ace doesn't update its editor: Force it:
      aceEditor.resize();
      aceEditor.getSession().setValue(aceEditor.getSession().getValue());
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
        code: (prepCode || '') + ';\n' + aceEditor.getSession().getValue(),
        framerate: 40
      });
    });

    if (options.onStartShow === 'run') {
      dom.nav.run.click();
    } else {
      dom.nav.edit.click();
    }

    // METHODS

    this.setEditableCode = function(code) {
      aceEditor.getSession().setValue(code);
    };

    this.setPrepCode = function(code) {
      prepCode = code;
    };

    this.run = function() {
      dom.nav.run.click();
    };

    this.edit = function() {
      dom.nav.edit.click();
    };

  }

 };
