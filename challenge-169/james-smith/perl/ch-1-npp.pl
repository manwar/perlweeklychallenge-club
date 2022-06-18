#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor);
use Time::HiRes qw(time);

my $time = time;

#-------------------------------------------------------------------------------
for( my( $c, $n, @f ) = 100; $c; ) {
  $c--, say $n if 2 == ( @f = factor ++$n ) && length $f[0] == length $f[1];
}

warn 'Time taken: ', time-$time, "\n";

