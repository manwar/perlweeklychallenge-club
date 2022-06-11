#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ product sum0 uniq };

my @pernicious;
my $i = 0;
while ( scalar @pernicious < 10 ) {
    $i++;
    if ( is_prime( count_ones( to_binary($i) ) ) ) {
        push @pernicious, $i;
    }
}
say join ', ', @pernicious;

sub count_ones( $n ) {
    return sum0 split //, $n;
}

sub to_binary( $n ) {
    return sprintf '%b', $n;
}

sub is_prime ($n) {
    return 0 if $n == 0 || $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}
