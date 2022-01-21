#!/usr/bin/env perl
# Week 148 Task 2
# Cardano Triplets
# Write a script to generate first 5 Cardano Triplets.
#    A triplet of positive integers (a,b,c) is called
#    a Cardano Triplet if it satisfies the below condition.

use strict;
use warnings;
use feature qw/ say /;
use POSIX qw/ cbrt sqrt /;

my $max     = 117;
my $counter = 0;

FIRST_FIVE: for my $a ( 1 .. $max ) {
    for my $b ( 1 .. $max ) {
        for my $c ( 1 .. $max ) {
            if ( ( cbrt( $a + $b * sqrt($c) ) + cbrt( $a - $b * sqrt($c) ) )
                == 1 )
            {
                say "($a, $b, $c)";
                $counter++;
                if ( $counter == 5 ) {
                    last FIRST_FIVE;
                }
            }
        }
    }
}

