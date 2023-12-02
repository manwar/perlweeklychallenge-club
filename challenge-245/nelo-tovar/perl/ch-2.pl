#!/usr/bin/env perl

# The Weekly Challenge 245 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
#
# Task 2 - Largest of Three
#

use strict;
use warnings;
use v5.28;
use Algorithm::Combinatorics qw(variations);
use Data::Dump qw(dump);

my @examples = (
    [ 8, 1, 9 ],
    [ 8, 6, 7, 1, 0 ],
    [ 1 ],
);

sub largest_of_three {
    my $ints = shift;
    my $length = scalar @$ints;
    my $max = -1;

    for (my $k = 1; $k <= $length; $k++) {
        my $iter = variations($ints, $k);

        while (my $v = $iter->next) {
            my $number = join ('', @$v);

            next if ($number % 3 != 0);
            $max = $number if ($number > $max)
        }
    }
     
    return $max;
}

for my $elements (@examples) {
    my $lot = largest_of_three $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $lot;
    say ' ';
}
