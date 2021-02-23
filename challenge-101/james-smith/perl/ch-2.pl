#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( winding_number(qw(0 1 1 0 2 2)), 0 );
is( winding_number(qw(0 1 -1 1 0 -3)), 1 );
is( winding_number(qw(0 1 2 0 -6 0)), 1 );

done_testing();

sub winding_number {
  ## Winding number is a generic way of working out whether a point lies
  ## within a polygon - as this is not difficult we can implement the
  ## trick for our triangle...
  ## We have to work with edges - each edge in the code is represented
  ## by ($a,$b) -> ($x,$y)... We start from the edge which joins the
  ## "last" node to the first and then we work our way around the circle
  ## The winding number goes up or down depening on whether the edge
  ## crosses the +ve axis (adding or subtracking 1 depending on the
  ## direction) - this boils down to the algorithm below..

  my ( $a, $b, $wn ) = @_[ -2, -1 ], 0;

  while( my($x,$y) = splice @_, 0, 2 ) {
    $wn += $a<=0 ? $y>0  && $a*$y-$x*$b >  0 ?  1 : 0
                 : $y<=0 && $a*$y-$x*$b <= 0 ? -1 : 0;
    ($a,$b)=($x,$y);
  }
  return $wn%2;
}

