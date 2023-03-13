#!/usr/bin/perl

use strict;
use warnings;

my $num = 1;

while (1) {
    my $square = $num * $num;
    my @digits = split( //, $square );
    my %unique_digits;

    foreach my $digit (@digits) {
        $unique_digits{$digit} = 1;
    }

    if ( scalar( keys %unique_digits ) >= 5 ) {
        print
"The first square number with at least 5 distinct digits is: $square\n";
        last;
    }

    $num++;
}
