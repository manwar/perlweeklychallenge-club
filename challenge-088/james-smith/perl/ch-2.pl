#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( "@{ spiral_matrix([1,2,3],[4,5,6],[7,8,9]) }", '1 2 3 6 9 8 7 4 5' );
is( "@{ spiral_matrix([1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]) }", '1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10' );

done_testing();

sub spiral_matrix {
  my @rows = map { [@{$_}] } @_;
  ## Note this is a destructive method... So we take a copy of the elements of the array o/w we will blow contents of sub-arrays away.
  my @res;
  while( @rows && @{$rows[0]} ) {
    ## We work around the square.....
    ## TOP      >>>> we just push to the answers... (and remove them from the array!)
    ## RIGHT    vvvv Remaining rows we take off the last element... and push to the answer array
    ## BOTTOM   <<<< (if there is one) we add it to the answers in reverse and remove from the array
    ## LEFT     ^^^^ Finally we push the first element of each row into the answers {note we go up the array
    ## Repeat until the array is empty (either has no rows or no columns [entries in first row])
    push @res,         @{shift @rows};
    push @res, pop     @{$_         } foreach grep { @{$_} }         @rows;
    push @res, reverse @{pop   @rows} if                             @rows;
    push @res, shift   @{$_         } foreach grep { @{$_} } reverse @rows;
  }
  return \@res;
}

