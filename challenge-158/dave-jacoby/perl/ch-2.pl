#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 };

my @cprimes;
for my $n ( 1 .. 1000 ) {
    if ( is_prime($n) ) {
        my $c = is_cuban_prime($n);
        push @cprimes, $n if $c;
    }
}
say join ', ', @cprimes;

sub is_cuban_prime ($n) {
    for my $i ( 1 ..  $n ) {
        my $c = sum0 1, ( 3 * $i ), ( 3 * ( $i**2 ) );
        return 1 if $c == $n;
    }
    return 0;
}

sub is_prime ($n) {
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}
