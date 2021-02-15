#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( triangle_sum( [1],[2,4],[6,4,9],[5,1,7,2] ), 8 );
is( triangle_sum( [3],[3,1],[5,2,3],[4,3,1,3] ), 7 );

done_testing();

## 72 chars ############################################################

## There are two directions you can go with this problem (up or down)
## Down may appear initially the best solution, but looking at it
## from the other angle - up is easier. We take off the last row of
## the triangle, and "merge it into" the line before - replacing
## the entry in the last row with the minimum of it's two "children"
## repeating until the triangle only has a single cell the answer..

sub triangle_sum {
  my @tri = @_;
  while(@tri>1) {
      ## Strip off base of triangle...
    my $b = pop @tri;
      ## Update new last line by adding smallest of it's "children"
    $tri[-1][$_] += $b->[$b->[$_]<$b->[$_+1]?$_:$_+1] for 0..@tri-1;
  }
  return $tri[0][0];
}

