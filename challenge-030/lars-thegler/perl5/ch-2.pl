#!/usr/bin/env perl

use Modern::Perl;
use Time::Piece;

# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and sum of the
# three numbers is always 12. For example, 3,4,5.

for my $a ( 1 .. 12 ) {
    for my $b ( 1 .. 12 ) {
        for my $c ( 1 .. 12 ) {
            next unless ( even($a) || even($b) || even($c) );
            next unless $a + $b + $c == 12;
            say "$a,$b,$c";
        }
    }
}

sub even { !!( $_[0] % 2 ) }
