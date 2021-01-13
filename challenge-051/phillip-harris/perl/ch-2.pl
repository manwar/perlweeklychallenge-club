#!/usr/env/perl
# Task 2 Challenge 051 Solution by phillip-harris
# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
# A number can be declare Colorful Number where all the products
# of consecutive subsets of digit are different.
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3,
# 2x6x3 are unique.

use strict;

my $numberofdigits = 3;
my $start          = 1 * 10**( $numberofdigits - 1 );
my $end            = 1 * 10**$numberofdigits - 1;

for ( my $x = $start ; $x <= $end ; $x++ ) {
    if ( &checkcolorful($x) == 1 ) {
        print "$x\n";
    }
}

sub checkcolorful() {
    my %products;
    my @digits = split //, $_[0];
    for ( my $x = 0 ; $x <= $#digits ; $x++ ) {
        for ( my $y = 0 ; $y + $x <= $#digits ; $y++ ) {
            my $total = 1;
            for ( my $z = 0 ; $z <= $x ; $z++ ) {
                $total = $total * $digits[ $y + $z ];
            }
            if ( $products{$total} == 1 ) {
                return 0;
            }
            else { $products{$total} = 1 }
        }
    }
    return 1;
}

