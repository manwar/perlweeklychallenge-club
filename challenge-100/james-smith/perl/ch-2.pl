#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## A little check to see if the sum functions are
## non-destructive...
my @Q = ( [1],[2,4],[6,4,9],[5,1,7,2] );
triangle_sum_1point5_liner( @Q );
is( triangle_sum_1point5_liner( @Q ), 8 );
@Q = ( [1],[2,4],[6,4,9],[5,1,7,2] );
triangle_sum( @Q );
is( triangle_sum( @Q ), 8 );

is( triangle_sum( [1],[2,4],[6,4,9],[5,1,7,2] ),  8 );
is( triangle_sum( [3],[3,1],[5,2,3],[4,3,1,3] ),  7 );
is( triangle_sum( [3],[3,1],[3,8,9],[4,3,1,3] ), 12 );
is( triangle_sum( [2],[3,7],[8,5,6],[6,1,9,3] ), 11 );
is( triangle_sum( [3],[6,4],[5,2,7],[9,1,8,6] ), 10 );

is( triangle_sum_1point5_liner( [1],[2,4],[6,4,9],[5,1,7,2] ),  8 );
is( triangle_sum_1point5_liner( [3],[3,1],[5,2,3],[4,3,1,3] ),  7 );
is( triangle_sum_1point5_liner( [3],[3,1],[3,8,9],[4,3,1,3] ), 12 );
is( triangle_sum_1point5_liner( [2],[3,7],[8,5,6],[6,1,9,3] ), 11 );
is( triangle_sum_1point5_liner( [3],[6,4],[5,2,7],[9,1,8,6] ), 10 );

done_testing();

display_sum( [1],[2,4],[6,4,9],[5,1,7,2] );
display_sum( [3],[3,1],[5,2,3],[4,3,1,3] );
display_sum( [3],[3,1],[3,8,9],[4,3,1,3] );
display_sum( [2],[3,7],[8,5,6],[6,1,9,3] );
display_sum( [3],[6,4],[5,2,7],[9,1,8,6] );


## 72 chars ############################################################

## There are two directions you can go with this problem (up or down)
## Down may appear initially the best solution, but looking at it
## from the other angle - up is easier. We take off the last row of
## the triangle, and "merge it into" the line before - replacing
## the entry in the last row with the minimum of it's two "children"
## repeating until the triangle only has a single cell the answer..

sub triangle_sum {
  my @tri = map{ [@{$_}] } @_;
  while(@tri>1) {
      ## Strip off base of triangle...
    my $b = pop @tri;
      ## Update new last line by adding smallest of it's "children"
    $tri[-1][$_] += $b->[
      $b->[$_] < $b->[$_+1] ? $_ : $_+1
    ] for 0..@tri-1;
  }
  return $tri[0][0];
}

## First thing we do is make a deep copy of @_ as this like the
## previous function is destructive. @_ is an array of references
## and although manipulating @_ doesn't affect the variable passed
## in it does affect the contents of any references passed in.
##
## We can convert the inner for loop into a map... and pop the value
## of $b in the while clause so we can simplify this down to a single
## one line statement, with the return just returning the last
## element of $b - here we are using the implicit my $b & return
##
## so not quite a 1 liner - but close enough!!

sub triangle_sum_1point5_liner {
  @_ = map{ [@{$_}] } @_; ## Deep copy as destructive..
  @{$_[-1]} = map {
    $_[-1][$_] + $b->[ $b->[$_] < $b->[$_+1] ? $_ : $_+1 ]
  } 0..@_-1 while @{$b=pop @_}>1;
  $b->[0];
}

## A subroutine to display the triangle indicating the route!
sub display_sum {
  my @tri = map{ [@{$_}] } @_; ## Deep copy the triangle as the
                               ## search is destructive
  my @route; ## For each node in the "current" bottom row, the route
             ## is the list of indecies of the child nodes that make
             ## up the "optimal" path
             ## We use the implicit my on $b
  while(@{$b = pop @tri}>1) {
    ($tri[-1][$_],$route[$_]) = $b->[$_]<$b->[$_+1]
      ? ( $tri[-1][$_] + $b->[$_],   [$_,  @{$route[$_  ]||[]}] )
      : ( $tri[-1][$_] + $b->[$_+1], [$_+1,@{$route[$_+1]||[]}] )
    foreach 0..@tri-1;
  }
  @route = (0,@{$route[0]}); ## We need to add the top node index
                             ## (always 0), at the same time we can
                             ##  just take the first (only)
                             ## path out of the 2d route matrix;
  print ## Assume all cell numbers are single digits...
    '',
    ( map {
      '  ' x (@_-($a=$_)), ## use implicit my on $a;
      ( map {
        sprintf $route[$a]==$_ ? '[%d] ': ' %d  ' , $_[$a][$_]
      } 0..$a ),
      "\n"
    } 0..@_-1 ),
    "\nMinimum path: ",(join ' -> ', map {
       $_[$_][$route[$_]] } 0..@_-1 ),' ; Total: ',$b->[0],"\n\n";
}
