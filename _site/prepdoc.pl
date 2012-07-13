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

my %keywords = (
  'color' => '/overview/Color.html',
  'easing' => '/overview/Easing.html',
  'shape' => '/overview/Shape.html',
  'animat(e|ion)' => '/overview/Animation.html'
);

my $destination = $ARGV[1];
$destination =~ s|[^/]$|$&\/|; # add slash if needed

my $html = read_file($ARGV[0]);
my $name = fileparse($ARGV[0]);
my $title;
my $relatedOverview = '';
my @categories = ('jsdoc');

# Extract title
if ($html =~ /<title>(.+?)<\/title>/) {
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

# Add keyword URL to page config
while ( my ($keyword, $keywordUrl) = each(%keywords) ) {
  if ($title =~ m/$keyword/i) {
    $relatedOverview = $keywordUrl;
  }
}

# Remove everything that's not inside <body>...</body>
$html =~ s/[\s\S]+<body>//;
$html =~ s/<\/body>[\s\S]+//;
$html =~ s/<nav>[\s\S]+?<\/nav>//; # remove navigation
$html =~ s/<h1[\s\S]+?<\/h1>//; # remove h1 title. h2 is sufficient (they're identical)
$html =~ s/<script[\s\S]+?<\/script>//g; # remove scripts
$html =~ s/<d[dt] class="tag-source">.+?<\/d[dt]>//g; # remove source/line-number detail

# Highlight code the "jekyll way":
$html =~ s/<pre class="sh_javascript"><code>/{% highlight javascript %}/g;
$html =~ s/<\/code><\/pre>/{% endhighlight %}/g;

# Add YAML Front matter config to the top of the file:
$html = <<END;
---
title: '$title'
layout: doc
categories: @categories
overview: '$relatedOverview'
---

$html

END
;

# Overwrite file with new content
open my $out, ">${destination}2012-01-01-$name" or die '$1';
print $out $html;
close $out;
