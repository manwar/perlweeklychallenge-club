#!/usr/local/bin/perl
use strict;

use warnings;
use feature qw(say);
use Cwd qw(getcwd);

BEGIN { push @INC, getcwd; };
use SVG;

my $config = {
  'margin' =>     40, 'max_w' =>   960, 'max_h' => 960,   # Size of image & margins
  'stroke' =>      5, 'color' => '#900',                  # Style for lines
  'radius' =>     10, 'fill'  => 'rgba(0,153,0,0.5)',     # Style for dots
  'border' => '#009', 'bg'    => '#ffd',                  # Style for "page"....
};

my $method = $0 eq 'fit.pl' ? 'render_with_best_fit' : 'render';

say sprintf '<!DOCTYPE html>
<html>
  <head>
    <title>Examples: %s</title>
  </head>
  <body>
    <h1>SVG examples: %s</h1>
    %s

  </body>
</html>', $0, $0, join "\n    ", map { join "\n", '', "<h2>$_</h2>", '', SVG->new( $config )->load_data( $_ )->$method } @ARGV ;

