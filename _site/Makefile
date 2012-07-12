ifndef JSDOC_DIR
    JSDOC_DIR=../bonsai/jsdoc/
endif

default: doc

# We grab all HTML files in BONSAI_DIR/jsdoc and send them through `prepdoc.pl`
doc:
	rm -rf _posts/processed_jsdoc
	mkdir _posts/processed_jsdoc
	find ${JSDOC_DIR} -name '*.html' -type f -exec perl prepdoc.pl {}  _posts/processed_jsdoc \;
