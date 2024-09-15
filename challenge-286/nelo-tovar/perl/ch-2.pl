#!/usr/bin/env perl

# The Weekly Challenge 286 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/
#
# Task 2 - Order Game
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use List::MoreUtils qw (minmax);
use Data::Dump qw(dump);

my @examples = (
    [ 2, 1, 4, 5, 6, 3, 0, 2  ],
    [ 0, 5, 3, 2  ],
    [ 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ],
);

sub order_game {
    my @ints = shift->@*;

    while ($#ints > 1) {
        my @temp;
        
        while ($#ints > 0) {
            push @temp, min((shift @ints, shift @ints));
            push @temp, max((shift @ints, shift @ints));
        }

        @ints = @temp;
    }

    return $ints[0]
}

for my $elements (@examples) {
    my $og = order_game $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $og;
    say ' ';
}
