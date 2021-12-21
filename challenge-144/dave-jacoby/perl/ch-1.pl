#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

say join ', ', grep { is_semiprime($_) } 1 .. 100;

sub is_semiprime ($n ) {
    my $done;
    return 0 if is_prime($n);
    my @factors =
        grep { !$done->{ $_->[0] }{ $_->[1] }++ }    # avoid replication
        grep { is_prime( $_->[0] ) }                 # factor 1 is prime
        grep { is_prime( $_->[1] ) }                 # factor 2 is prime
        map  { [ sort $_, $n / $_ ] }                # both applicable factors
        grep { 0 == $n % $_ }                        # is a factor
        2 .. sqrt $n;
    return scalar @factors == 1 ? 1 : 0;
}

sub is_prime ($n) {
    for ( 2 .. sqrt $n ) { return unless $n % $_ }
    return 1;
}
