#!/usr/bin/env perl
# Week 145 Task 1
# Dot Product

use strict;
use warnings;
use feature qw/ say /;

my @a = ( 1, 2, 3 );
my @b = ( 4, 5, 6 );

# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32

say dot_product( \@a, \@b );

sub dot_product {
    my ( $a_ref, $b_ref ) = @_;
    my @a   = @{$a_ref};
    my @b   = @{$b_ref};
    my $len = scalar @a;
    my $sum = 0;
    for ( 0 .. ( $len - 1 ) ) {
        $sum += ( $a[$_] * $b[$_] );
    }
    return $sum;
}
