#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 product };
use Memoize;

memoize('is_prime');

my @aprimes;
for my $i ( 1 .. 100 ) {
    if ( is_prime($i) ) {
        my $sum = sum0 split //, $i;
        if ( is_prime($sum) ) { push @aprimes, $i; }
    }
}
say join ', ', @aprimes;

sub is_prime ($n) {
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}
