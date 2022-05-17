#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my(@lines,@pts);

get_points_and_lines( );
add_best_fit_line( 20 ) if $0 eq 'ch-2.pl';
say render_svg( \@pts, \@lines, {
  'margin' => 10,     'max_w' => 960,    'max_h' => 540,   # Size of image & margins
  'stroke' => 5,      'color' => '#900'                    # Style for lines
  'radius' => 10,     'fill'  => '#090',                   # Style for dots
  'border' => '#009', 'bg'    => '#ffd',                   # Style for "page"....
} );

## Compute the best fit line for the points array (using linear regression...
## Assumes a dependency of y on x....

sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  ( ($sy-$b*$sx)/$n, $b );
}

sub get_points_and_lines {
  my @t;
  while(<>) {
    chomp;
    4 == (@t = split /,/) ? ( push @lines, [@t] ) : ( push @pts, [@t] ) for split;
  }
}

sub add_best_fit_line {
  my $extn = shift // 40;
  my( $a, $b                         ) = best_fit(   \@pts );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( \@pts );
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ($l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ($l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ($r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ($r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  push @lines, [ $l_x,$l_y,$r_x,$r_y ];
}

sub get_ranges {
  my( $pts, $lines ) = @_;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$pts} ? @{$pts->[0]} : @{$lines->[0]};
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$pts}, map {($_,[$_->[2],$_->[3]])} @{$lines};
  ( $min_x, $max_x, $min_y, $max_y );
}

sub render_svg {
  my( $pts, $lines, $config          ) = @_;
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );
  my $margin = $config->{'margin'}//20;
  my($W,$H,$width,$height) = ($config->{'max_w'}//800,$config->{'max_h'}//600,$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  my $sf = $width/$W;
  return sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
      join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_} } @{$lines} ),
    $config->{'color'}//'#ccc',                                                    ## dots
      join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',  @{$_}, ($config->{'radius'}//10)*$sf  } @{$pts}   );

         $config->{'border'}//'#000', $sf, $min_x - $margin, $min_y - $margin, $width, $height,
         $config->{'fill'}//'#000', ($config->{'stroke'}//5) * $sf, $config->{'bg'}//'#eee',
         join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_} } @{$lines} ),
         $config->{'color'}//'#ccc',
         join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',  @{$_}, ($config->{'radius'}//10)*$sf  } @{$pts}   );
}
