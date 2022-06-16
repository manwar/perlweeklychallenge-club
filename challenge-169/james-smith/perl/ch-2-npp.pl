#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor_exp gcd);
use Time::HiRes qw(time);

my $time = time;

#-------------------------------------------------------------------------------
for( my( $c, $n ) = ( 100 ); $c; ) {
  $c--, say $n if 1 == gcd map{ $_->[1] < 2 ? next : $_->[1] } factor_exp ++$n;
}

warn 'Time taken: ', time-$time, "\n";

