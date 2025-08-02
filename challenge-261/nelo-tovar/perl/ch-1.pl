#!/usr/bin/env perl

# The Weekly Challenge 261 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
#
# Task 1 - Element Digit Sum
#

use strict;
use warnings;
use v5.28;
use List::Util qw/sum0/;
use Data::Dump qw(dump);

my @examples = (
    [ 1,2,3,45 ],
    [ 1,12,3 ],
    [ 1, 2, 3, 4 ],
    [ 236, 416, 336, 350 ],
);

sub element_digit_sum {
    my $nums = shift;
    my $sum = 0;

    foreach my $x (@$nums) {
        next if $x <= 9;

        $sum += $x - sum0(split //, $x); 
    }

    return abs($sum);
}

for my $elements (@examples) {
    my $eds = element_digit_sum $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $eds;
    say ' ';
}
