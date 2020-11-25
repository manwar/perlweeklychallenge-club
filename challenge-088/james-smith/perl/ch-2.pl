#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( "@{ spiral_matrix([1,2,3],[4,5,6],[7,8,9]) }", '1 2 3 6 9 8 7 4 5' );
is( "@{ spiral_matrix([1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]) }", '1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10' );

done_testing();

sub spiral_matrix {
  my @rows = @_;
  my @res;
  while(@rows) {
    push @res, @{shift @rows};
    push @res, pop @{$_}              foreach grep { @{$_} } @rows;
    push @res, reverse @{ pop @rows } if @rows; ## Make sure we have data!
    push @res, shift @{$_}            foreach grep { @{$_} } reverse @rows;
  }
  return \@res;
}

