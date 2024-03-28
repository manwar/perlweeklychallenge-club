#!/usr/bin/env perl

# The Weekly Challenge 262 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
#
# Task 1 - Max Positive Negative
#

use strict;
use warnings;
use v5.28;
use List::Util qw /max min/;
use Data::Dump qw(dump);

my @examples = (
    [ -3, 1, 2, -1, 3, -2, 4 ],
    [ -1, -2, -3, 1 ],
    [ 1, 2 ],
);

sub max_positive_negative {
    my $nums = shift;
    my $positive = max(grep {$_ >= 0} @$nums);
    my $negative = abs(min(grep {$_ < 0 } @$nums));

    return $positive > $negative ? $positive : $negative;
}

for my $elements (@examples) {
    my $mpn = max_positive_negative $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $mpn;
    say ' ';
}
