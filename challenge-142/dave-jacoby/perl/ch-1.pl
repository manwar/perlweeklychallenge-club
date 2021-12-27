#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @examples;
push @examples, [ 24, 2 ];
push @examples, [ 30, 5 ];

for my $e (@examples) {
    my ( $m, $n ) = $e->@*;
    my $o = divisor_last_digit( $m, $n );
    say <<"END";
    Input:  \$m = $m, \$n = $n
    Output: $o
END
}

sub divisor_last_digit ( $m, $n ) {
    my @divisors;
    for my $i ( 1 .. $m ) {
        if ( $m % $i == 0 ) {
            push @divisors, $i;
        }
    }
    return scalar grep { $n == substr $_, -1, 1 } @divisors;
}
