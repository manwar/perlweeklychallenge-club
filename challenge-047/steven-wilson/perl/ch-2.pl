#!/usr/bin/env perl
# Steven Wilson
# Challenge 047 Task #2
# 12 Feb 2020

# Gapful Number
# Write a script to print first 20 Gapful Numbers greater than or equal
# to 100. Please check out the page for more information about Gapful
# Numbers.

use strict;
use warnings;
use feature qw/ say /;

my @gapful_numbers;
my $current_number = 100;

while ( scalar @gapful_numbers < 20 ) {
    my $divisor = ( substr $current_number, 0, 1 )
        . ( substr $current_number, -1, 1 );
    if ( $current_number % $divisor == 0 ) {
        push @gapful_numbers, $current_number;
    }
    $current_number++;
}

say join ' ', @gapful_numbers;
