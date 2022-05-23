#!/usr/local/bin/perl
use strict;

use warnings;
use feature qw(say);

my $CONFIG = {
  'margin' =>     40, 'max_w' =>    960, 'max_h' => 540,   # Size of image & margins
  'stroke' =>      5, 'color' => '#900',                   # Style for lines
  'radius' =>     10, 'fill'  => '#090',                   # Style for dots
  'border' => '#009', 'bg'    => '#ffd',                   # Style for "page"....
};

my ($pts,$lines) = get_points_and_lines( );                   ## Parses file and updates lines/points
add_best_fit_line(    $pts, $lines, $CONFIG->{'margin'} ) if $0 eq 'ch-2.pl'; ## Only if fitting line!
say render_svg(       $pts, $lines, $CONFIG );                ## Pass in config to render correctly

##----------------------------------------------------------------------
## Now the code does the real work....
##----------------------------------------------------------------------

## Parse stdin / files given on command line, to return a list of points and lines..
sub get_points_and_lines {
  my($ps,$ls,@t)=([],[]);
  local $/ = undef;

    4 == (@t = split /,/) ? ( push @{$ls}, [@t]      )       ## Length 4 - line
  : 2 == @t               ? ( push @{$ps}, [@t]      )       ## Length 2 - point
  :                         ( warn "input error: $_" )       ## o/w error
                                                       for grep { $_ } split /\s+/, <>;
  return ($ps,$ls);
}

## Compute the best fit line for the points array (using linear regression...
## Assumes a dependency of y on x....

sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  return $sx/$n unless $n*$sxx - $sx*$sx;
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  ( ($sy-$b*$sx)/$n, $b );
}

## Get the range of x,y values for the given list of lines/points
## Returns a tuple of min & max x and min & max y.

sub get_ranges {
  my( $ps, $ls ) = @_;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$ps} ? @{$pts->[0]} : @{$ls->[0]};
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$ps}, map {($_,[$_->[2],$_->[3]])} @{$ls||[]};
  ( $min_x, $max_x, $min_y, $max_y );
}

## Get the best fit line, and then add extend it to edge of the box - by default we assume that the line will start/end on
## the side of the box, but just to be sure - we check to see if the pts lie above or below the top/bottom of the box and
## move them appropriately.

sub add_best_fit_line {
  my ($ps,$ls,$extn) = @_;
  $extn //= 40;
  my( $a, $b                         ) = best_fit(   $ps );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $ps );
  unless( defined $b ) {
    push @{$ls}, [ $a, $min_y - $extn, $a, $max_y + $extn];
    return;
  }
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ($l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ($l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ($r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ($r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  push @{$ls}, [ $l_x,$l_y,$r_x,$r_y ];
}

## Finally the rendering of the points/lines, this uses most of the config entries to deal with colour, size etc.
## We get the range and again add the margin { we don't include the lines in the equation if we are doing challenge 2
## the line fitting as otherwise we would extend the region twice... }
##
## Once we have the size of the image - we work out it's aspect ratio and work out whether we have to make the image
## narrower or shorter so that the image is no-bigger than the suggested size and that the image is as big as possible
##
## As we have a scaling between the x+y values and the size of the image - we need to adjust the size of dots/width of lines
## by multiplying these all by a scale factor

sub render_svg {
  my( $ps, $ls, $config          ) = @_;
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );
  my $margin = $config->{'margin'}//20;

  ## Adjust height and width so it fits the size from the config.
  my($W,$H,$width,$height) = ($config->{'max_w'}//800,$config->{'max_h'}//600,$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  ## Calculate the scale factor so that we keep spots/lines the same size irrespective of the ranges.
  my $sf = $width/$W;

  sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%s" width="%s" viewBox="%s %s %s %s" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="%s" stroke-width="%s" fill="%s" x="%s" y="%s" width="%s" height="%s" />
  <g stroke="%s" stroke-width="%s">
    %s
  </g>
  <g fill="%s">
    %s
  </g>
</svg>',
    $H, $W, $min_x - $margin, $min_y - $margin, $width, $height,                   ## svg element
    $config->{'border'}//'#000', $sf, $config->{'bg'}//'#eee',                     ## background rectangle
      $min_x - $margin, $min_y - $margin, $width, $height,
    $config->{'fill'}//'#000', ($config->{'stroke'}//5) * $sf,                     ## lines
      join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_} } @{$ls} ),
    $config->{'color'}//'#ccc',                                                    ## dots
      join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',  @{$_}, ($config->{'radius'}//10)*$sf  } @{$ps}   )
}
