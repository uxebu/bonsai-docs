#!/usr/bin/perl

#--
# Expects two arguments:
#  [0] is the source html jsdoc file
#  [1] is the destination folder for the processed html file
#
# This script takes a JSDoc (v3) generated file, and prepares it for the
# bonsai-docs run in jekyll. This includes stripping everything except what's
# inside <body> and adding YAML config. We also have to save the file into
# /_posts/ with a YYYY-MM-DD-TITLE.html format otherwise jekyll will not
# recognize it.
#--

use strict;
use warnings;
use File::Slurp;
use File::Basename;

my $destination = $ARGV[1];
$destination =~ s|[^/]$|$&\/|; # add slash if needed

my $text = read_file($ARGV[0]);
my $name = fileparse($ARGV[0]);
my $title;
my @categories = ('jsdoc');

# Extract title
if ($text =~ /<title>(.+?)<\/title>/) {
  $title = $1;
} else {
  die "No title found (<title>...</title>) in ${name}";
}

# Don't process Index. We don't need it
if ($title eq 'Index') {
  exit;
}

# Add appropriate category:
if ($title =~ /Class/) { push @categories, 'Class'; }
if ($title =~ /Module/) { push @categories, 'Module'; }
if ($title =~ /Mixin/) { push @categories, 'Mixin'; }

$title =~ s/JSDoc: (?:Class|Mixin|Module): //;

# Remove everything that's not inside <body>...</body>
$text =~ s/[\s\S]+<body>//;
$text =~ s/<\/body>[\s\S]+//;
$text =~ s/<nav>[\s\S]+?<\/nav>//; # remove navigation
$text =~ s/<h1[\s\S]+?<\/h1>//; # remove h1 title. h2 is sufficient (they're identical)
$text =~ s/<script[\s\S]+?<\/script>//g; # remove scripts
$text =~ s/<d[dt] class="tag-source">.+?<\/d[dt]>//g; # remove source/line-number detail

# Highlight code the "jekyll way":
$text =~ s/<pre class="sh_javascript"><code>/{% highlight javascript %}/g;
$text =~ s/<\/code><\/pre>/{% endhighlight %}/g;

# Add YAML Front matter config to the top of the file:
$text = <<END;
---
title: '$title'
layout: doc
categories: @categories
---

$text

END
;

# Overwrite file with new content
open my $out, ">${destination}2012-01-01-$name" or die '$1';
print $out $text;
close $out;
