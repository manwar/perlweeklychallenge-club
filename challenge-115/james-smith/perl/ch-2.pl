#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [[qw(4 1 7 6)], 7614],
  [[qw(1 4 2 8)], 8412],
  [[qw(1 0 2 6)], 6210],
  [[qw(1 7 9 6)], 9716],
  [[qw(1 7 3 5)], ''],
  [[qw(1 7 3 8)], 7318],
  [[qw(2 4 6 8)], 8642],
);

is( biggest_even(    $_->[0] ), $_->[1] ) foreach @TESTS;

sub biggest_even {
  my $ptr = my @digits = reverse sort @{$_[0]};

  ## Firstly grab the digits in reverse numerical order
  ## Keep looping backwards through the array until we
  ## find a digit which is even - if this is the case
  ## we move it to the back and return the list.

  while( $ptr-- ) {
    next if $digits[$ptr] & 1; ## Skip if odd...
    return join '',
      @digits[ 0..$ptr-1, $ptr+1..$#digits, $ptr ];
  }

  ## If we get to the start return 0 as there are no even digits!
  return '';
}

