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

# Define keywords and their associated pages so that we can build a
# list of related links to display in the page:
my %keywords = (
  'color' =>
    ['Color', '/overview/Color.html'],
  'easing' =>
    ['Easing', '/overview/Easing.html'],
  'shape' =>
    ['Shape', '/overview/Shape.html'],
  'animat(e|ion)' =>
    ['Animation', '/overview/Animation.html'],
  'new Path|Path\.(rect|star|ellipse|circle|polygon|arc)' =>
    ['Path', '/overview/Path.html'],
  'new (Rect|Star|Ellipse|Circle|Polygon|Arc)' =>
    ['Simple Shapes', '/overview/SimpleShapes.html'],
  'new Group|Group' =>
    ['Groups', '/overview/Groups.html']
);

my $destination = $ARGV[1];
$destination =~ s|[^/]$|$&\/|; # add slash if needed

my $html = read_file($ARGV[0]);
my $name = fileparse($ARGV[0]);
my $title;
my @relatedLinks = ();
my @relatedNames = ();
my @categories = ('jsdoc');
my $alpha = join '', ('A'..'Z');

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

# Remove blank lines:
$html =~ s/\n\s*(?=\n)//g;

# Match against the entire HTML to find any keywords.
# If we find matches, then we can add to the relatedLinks.
foreach my $keyword (keys %keywords) {
  if ($html =~ m/$keyword/) {
    my @keywordLink = @{$keywords{$keyword}};
    push @relatedNames, $keywordLink[0];
    push @relatedLinks, $keywordLink[1];
  }
}

# Create 'YAML Front Matter' List:
my $relatedLinksString = '';
my $relatedNamesString = '';
if (@relatedLinks) {
  $relatedLinksString = ' - ' . (join "\n - ", @relatedLinks);
  $relatedNamesString = ' - ' . (join "\n - ", @relatedNames);
}

my $categoryString = '';
if (@categories) {
  $categoryString = '[' . (join ", ", @categories) . ']'
}

# Add YAML Front matter config to the top of the file:
$html = <<END;
---
title: '$title'
layout: doc
categories: $categoryString
relatedLinks:
$relatedLinksString
relatedNames:
$relatedNamesString
---

$html

END
;

# Get title's index in alphabet and apply that to the date
# in the filename. Jekyll uses the date to determine ordering.
my $alphaIndex = 26 - index $alpha, uc substr $title, 0, 1;
$alphaIndex = $alphaIndex < 10 ? '0' . $alphaIndex : '' . $alphaIndex;

# Overwrite file with new content
open my $out, ">${destination}2012-01-$alphaIndex-$name" or die '$1';
print $out $html;
close $out;
