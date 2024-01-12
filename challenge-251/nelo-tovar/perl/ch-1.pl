#!/usr/bin/env perl

# The Weekly Challenge 251 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
#
# Task 1 - Concatenation Value
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 6, 12, 25, 1 ],
    [ 10, 7, 31, 5, 2, 2 ],
    [ 1, 2, 10 ],
);

sub concatenation_value {
    my @ints = shift->@*;
    my $value = 0;

    while ( scalar @ints > 0 ) {
        my $first = shift @ints;     
        my $last =  scalar @ints ? pop @ints : '';     

        $value += "${first}${last}";
    }

    return $value;
}

for my $elements (@examples) {
    my $cv = concatenation_value $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $cv;
    say ' ';
}
