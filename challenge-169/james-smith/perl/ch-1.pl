#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor);
use Time::HiRes qw(time);

my $time = time;

# Within each loop we get a factorisation
# must have preciesely 2 prime factors
# THEN each factor must be the same length;

for( my( $n, $c, $MAX, @f ) = ( 0, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  say sprintf '%8d: %10d = %5d x %d', ++$c, $n, @f
    if 2 == ( @f = factor $n ) && length $f[0] == length $f[1];
}

warn 'Time taken: ', time-$time, "\n";

