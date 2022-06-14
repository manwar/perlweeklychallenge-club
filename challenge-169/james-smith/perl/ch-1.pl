#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor);
use Time::HiRes qw(time);

my $time = time;
open my $fh, '>', 'factor.txt';

for( my( $n, $c, $MAX, @f ) = ( 0, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  say {$fh} sprintf '%10d: %30d %10d %10d', ++$c, $n, @f
    if 2 == ( @f=factor($n) ) && length( $f[0] ) == length $f[1];
}

close $fh;
warn 'Time taken: ', time-$time, "\n";

