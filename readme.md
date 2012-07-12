## Bonsai Documentation website repo

This repository contains documentation for the Bonsai graphics library.

### Notes

 * General overview (`md`/`html`) files are placed in `overview/`. Do not place any JSdoc files in there.
 * Processed JSDoc files are located in `_posts/processed_jsdoc` (they're added there automatically by the `make doc` script)
 * Processed JSDoc files are located in _posts and name in the format `YYYY-MM-DD-title.html` (actual date is irrelevant) because we want to utilise Jekyll's blog "mode" which allows posts to have categories. And categories may be useful down the line.

### How to add JSDoc files

 1) Make sure you've generated the `jsdoc/` directory in your bonsai repo
 2) Come to the bonsai-docs (this) directory and run `make JSDOC_DIR=../path/to/bonsai/jsdoc/`
 3) Check `_posts/processed_jsdoc` -- it should now be populated.

## Run the site locally

 1) [Install Jekyll](https://github.com/mojombo/jekyll/wiki/Install)
 2) Run `jekyll --auto --server` and visit `localhost:4000`
