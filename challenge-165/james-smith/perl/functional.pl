#!/usr/local/bin/perl
use strict;

use warnings;
use feature qw(say);

my $DEF            = { 'margin' => 40, 'max_w' => 960, 'max_h' => 540,
                       'color' => '#000',  'stroke' => 3,
                       'fill' => '#ccc',   'radius' => 10,
                       'border' => '#000', 'bg' => '#eee' };
my $LINE_TEMPLATE  = '<line x1="%s" y1="%s" x2="%s" y2="%s" />';
my $POINT_TEMPLATE = '<circle cx="%s" cy="%s" r="%s" />';
my $SVG_TEMPLATE   = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%s" width="%s" viewBox="%s %s %s %s" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="%s" stroke-width="%s" fill="%s" x="%s" y="%s" width="%s" height="%s" />
  <g transform="scale(1,-1) translate(0,%s)">
  <g stroke="%s" stroke-width="%s">
    %s
  </g>
  <g fill="%s">
    %s
  </g>
  </g>
</svg>';

my $config = {
  'margin' =>     40, 'max_w' =>    960, 'max_h' => 540,   # Size of image & margins
  'stroke' =>      5, 'color' => '#900',                   # Style for lines
  'radius' =>     10, 'fill'  => 'rgba(0,153,0,0.5)',      # Style for dots
  'border' => '#009', 'bg'    => '#ffd',                   # Style for "page"....
};

my $html = '<html><head><title>Examples</title></head><body><h1>SVG examples</h1>';
for ( @ARGV ) {
  my ($pts,$lines) = get_points_and_lines( $_ );                  ## Parses file and updates lines/points
  add_best_fit_line( $pts, $lines, $config->{'margin'} ) if $0 eq 'ch-2.pl'; ## Only if fitting line!
  $html .= "<h2>$_</h2>". render_svg( $pts, $lines, $config );    ## add to HTML
}
say $html.'</body></html>';

##----------------------------------------------------------------------
## Now the code does the real work....
##----------------------------------------------------------------------

## Parse stdin / files given on command line, to return a list of points and lines..
sub get_points_and_lines {
  my($ps,$ls,@t)=([],[]);
  local $/ = undef;
  open my $ifh, '<', $_[0];

    4 == (@t = split /,/) ? ( push @{$ls}, [@t]      )       ## Length 4 - line
  : 2 == @t               ? ( push @{$ps}, [@t]      )       ## Length 2 - point
  :                         ( warn "input error: $_" )       ## o/w error
                                                       for grep { $_ } split /\s+/, <$ifh>;
  close $ifh;
  ($ps,$ls);
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
## Returns a 4-tuple of min & max x and min & max y.

sub get_ranges {
  my( $ps, $ls ) = @_;

  ## rather than having a special cast as the first part of the loop, we start with the
  ## values for the first point (or start of line if no points)
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$ps} ? @{$ps->[0]} : @{$ls->[0]};

  ## Compute the range of all points. We comma separate conditions so we only need one postfix for
  ## We use ($c)&&($a=?) to mimic if($c) { $a=? } so we can use the postfix loop...
  ## Note we unravel the two ends of the line by mapping the each line ($_) to $_ + the last two values $_.
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$ps}, map {($_,[$_->[2],$_->[3]])} @{$ls||[]};

  ( $min_x, $max_x, $min_y, $max_y );
}

## Get the best fit line, and then extend it to edge of the box - by default we start with the line going from the left
## hand edge of the box to the right hand end. If either of these points lies outside the box we adjust the y-coord to
## the top/bottom of the box, and then alter the x coordinate.
## We treat the special case where the line is vertical ($b then contains the x-coordinate of all the points... by drawing
## a vertical line...
##
## Note we use the trick of assigning values (the new y-position) with in the ternary operators computing the x-position
## of the ends...

sub add_best_fit_line {
  my ($ps,$ls,$extn) = @_;
  $extn //= $DEF->{'margin'};

  my( $a, $b                         ) = best_fit(   $ps );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $ps );

  ## special case of a vertical line
  push( @{$ls}, [ $a, $min_y - $extn, $a, $max_y + $extn]), return unless defined $b;

  ## Normal case - get y coprdinates of end points, adjust if outside the box...
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ( $l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ( $l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ( $r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ( $r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;

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
  my %conf = (%{$DEF}, %{$config});
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $ps, $0 eq 'ch-2.pl' ? [] : $ls );
  my $margin = $conf{'margin'};

  ## Adjust height and width so it fits the size from the config.
  my($W,$H,$width,$height) = ($conf{'max_w'},$conf{'max_h'},$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  ## Calculate the scale factor so that we keep spots/lines the same size irrespective of the ranges.
  my $sf = $width/$W;

  sprintf $SVG_TEMPLATE,
    $H,              $W,               $min_x - $margin, $min_y - $margin, $width, $height,                    ## svg element
    $conf{'border'}, $sf, $conf{'bg'}, $min_x - $margin, $min_y - $margin, $width, $height,                    ## bg rect
    -$min_y-$max_y,
    $conf{'color'}, $conf{'stroke'} * $sf, join( qq(\n    ), map { sprintf $LINE_TEMPLATE,   @{$_} } @{$ls} ), ## lines
    $conf{'fill'}, join( qq(\n    ), map { sprintf $POINT_TEMPLATE,  @{$_}, $conf{'radius'}*$sf  } @{$ps}   )  ## points
}

