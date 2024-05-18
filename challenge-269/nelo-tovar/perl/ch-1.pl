#!/usr/bin/env perl

# The Weekly Challenge 269 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
#
# Task 1 - Bitwise OR
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 1, 2, 3, 4, 5 ],
    [ 2, 3, 8, 16 ],
    [ 1, 2, 5, 7, 9 ],
);

sub bitwise_or {
    my $nums = shift;
    my $length = scalar @$nums;

    for (my $i = 0; $i < $length - 1; $i++) {
        for (my $j = $i + 1; $j < $length; $j++) {
           my $k = $nums->[$i] | $nums->[$j];

           return 'true' if (($k % 2) == 0);
        }
    }

    return 'false';
}

for my $elements (@examples) {
    my $bo = bitwise_or $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $bo;
    say ' ';
}
