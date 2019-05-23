#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-05-21
# Challenge #9
# Write a script that finds the first square number that has at least
# 5 distinct digits. This was proposed by Laurent Rosenfeld.

use warnings;
use strict;
use feature qw/ say /;

my $number   = 0;
my $found    = 0;
my $distinct = 5;
my $square;

while ( !$found ) {
    $square = $number**2;
    my $distinct_digits = get_distinct($square);
    if ( $distinct_digits == $distinct ) { $found = 1 }
    $number++;
}

say "The square of " . ( $number - 1 )
    . " ($square) is the first square that has at least $distinct distinct digits.";

sub get_distinct {
    my $number = shift;
    my %unique = ();
    undef @unique{ ( split //, $number ) };
    return keys %unique;
}
