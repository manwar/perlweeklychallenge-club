#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $margin = 10;
my $extn   = 20;
my $radius = 10;
my $stroke =  5;

my(@t,@lines,@pts);

## Swallow the input into two arrays - one of pts and one of lines
## Note we allow multiple data points on the same line (as per example 2)
while(<>) {
  chomp;
  warn $_;
  4==(@t = split /,/) ? (push @lines,[@t]) : (push @pts,[@t]) for split;
}

## If the code is programme 2 we then calculate the line of best fit,
## and compute where it crosses the sizes of our box....

if( $0 eq 'ch-2.pl' ) {
  my ($a,$b) = best_fit(   \@pts );
  my ($min_x, $max_x, $min_y, $max_y) = get_ranges( \@pts );

  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $min_x - $extn;
  my $r_x = $max_x + $extn;

  $l_x = ( ($l_y = $min_y - $extn ) - $a)/$b if $l_y < $min_y - $extn;
  $l_x = ( ($l_y = $max_y + $extn ) - $a)/$b if $l_y > $max_y + $extn;
  $r_x = ( ($r_y = $min_y - $extn ) - $a)/$b if $r_y < $min_y - $extn;
  $r_x = ( ($r_y = $max_y + $extn ) - $a)/$b if $r_y > $max_y + $extn;

  push @lines, [ $l_x,$l_y,$r_x,$r_y ];
}

say render_svg( \@pts, \@lines, { 'max_w' => 960, 'max_h' => 540 } );

## This computes the equation for the regression line...
sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx    += $_->[0], $sxy += $_->[0]*$_->[1],
    $sy  += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  my $a = ($sy - $b * $sx)/$n;
  return ( ($sy-$b*$sx)/$n, $b );
}

## Get max and min values for array of points/lines
sub get_ranges {
  my( $pts, $lines ) = @_;

  ## Set min/max x/y to the first point (or the start of the first line)
  my $min_x = my $max_x = @pts ? $pts->[0][0] : $lines->[0][0];
  my $min_y = my $max_y = @pts ? $pts->[0][1] : $lines->[0][1];

  ## We loop through all points + all starts/ends of lines { this is what the map does }
  ## We can make this a single postfix for by using "," to separate the statements and
  ## using A && B as a proxy to B if A.....
  ( $_->[0] < $min_x ) && ( $min_x = $_->[0] ),
  ( $_->[0] > $max_x ) && ( $max_x = $_->[0] ),
  ( $_->[1] < $min_y ) && ( $min_y = $_->[1] ),
  ( $_->[1] > $max_y ) && ( $max_y = $_->[1] ) for @{$pts}, map { ($_, [$_->[2],$_->[3]]) } @{$lines};

  return ( $min_x, $max_x, $min_y, $max_y );
}

sub render_svg {
  my( $pts, $lines, $config          ) = @_;
                                         ## We don't want to expand around line of best fit so don't include it in
                                         ## the range expansion.
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );

  my( $width,$height                 ) = ( $max_x - $min_x + 2 * $margin, $max_y - $min_y + 2 * $margin );

  ## Compute the bounding box of the graph such that is limited by the W/H specified
  my $W = $config->{'max_w'}//800; my $H = $config->{'max_h'}//600;
  ## If it's aspect ratio wider than the given aspect ratio we make the height shorter
  ## Otherwise we make the width narrower...
  if( $width/$height > $W/$H ) {
    $H = $height/$width*$W;
  } else {
    $W = $width/$height*$H;
  }
  ## Scale-factor we resize points and lines so that the points/lines will look the same size irrespective of the
  ## ratio of virtual size of region and physical size of SVG.
  my $sf = $width/$W;

  ## Finally we pull this altogether in our SVG template using sprintf, join/map/sprintf for the sizes, lines & points.
  return sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%s" width="%s"
     viewBox="%s %s %s %s" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="#000" stroke-width="%s" fill="#eee" x="%s" y="%s" width="%s" height="%s" />
  <g stroke="#900" stroke-width="%s">
    %s
  </g>
  <g fill="#090">
    %s
  </g>
</svg>
', $H, $W,
         $min_x - $margin, $min_y - $margin, $width, $height,
         $sf, $min_x - $margin, $min_y - $margin, $width, $height, $stroke*$sf,
         join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_}               } @{$lines} ),
         join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',        @{$_}, $radius*$sf  } @{$pts}   );
}
