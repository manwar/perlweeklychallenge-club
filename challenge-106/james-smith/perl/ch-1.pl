#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( max_gap((2, 9, 3, 5)), 4 );
is( max_gap((1, 3, 8, 2, 0)), 5 );
is( max_gap((5)), 0 );

done_testing();

sub max_gap {
  my( $max, $p, @sorted ) = ( 0, sort { $a <=> $b } @_ );

  # Shift off first value ($p), we will loop through @sorted and
  # compare the difference between value and previous value ($p).
  # At the end of each iteration we will replace $p with the next
  # value (in the loop $_)
  #
  # This saves us having to loop through elements using an index
  # and calculating - $sorted[$_+1]-$sorted[$_]..

  foreach ( @sorted ) {
    $max = $_ - $p if $_ - $p > $max;
    $p   = $_;
  }

  return $max;
}
