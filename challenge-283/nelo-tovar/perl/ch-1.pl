#!/usr/bin/env perl

# The Weekly Challenge 283 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
#
# Task 1 - Unique Number
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(frequency);
use Data::Dump qw(dump);

my @examples = (
    [ 3, 3, 1 ],
    [ 3, 2, 4, 2, 4 ],
    [ 1 ],
    [ 4, 3, 1, 1, 1, 4]
);

sub unique_number {
    my $nums = shift;
    my %frequencies = frequency $nums->@*;

    foreach my $key (keys %frequencies) {
        return $key if ($frequencies{$key} eq 1)
    }

    return '' 
}

for my $elements (@examples) {
    my $un = unique_number $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $un;
    say ' ';
}
