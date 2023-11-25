#!/usr/bin/env perl

# The Weekly Challenge 244 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
#
# Task 2 - Group Hero
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    [ 2, 1, 4 ],
);

sub group_hero {
    my $nums = shift;
    my $length = scalar @$nums;
    my $sum = 0;

    for (my $k = 1; $k <= $length; $k++) {
        my $iter = combinations($nums, $k);

        while (my $c = $iter->next) {
            $sum += (max(@$c) ** 2) * min(@$c)
        }
    }
     
    return $sum;
}

for my $elements (@examples) {
    my $gh = group_hero $elements;

    say 'Input : @nums = ', dump(@$elements);
    say 'Output : ', $gh;
    say ' ';
}
