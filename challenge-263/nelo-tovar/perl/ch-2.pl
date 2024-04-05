#!/usr/bin/env perl

# The Weekly Challenge 263 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
#
# Task 2 - Merge Items
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    [ [ [1,1], [2,1], [3,2] ],
      [ [2,2], [1,3] ]
    ],
    [ [ [1,2], [2,3], [1,3], [3,2] ],
      [ [3,1], [1,3] ]
    ],
    [ [ [1,1], [2,2], [3,3] ],
      [ [2,3], [2,4] ]
    ],
);

sub merge_items {
    my $nums = shift;
    my $length = scalar @$nums;
    my @items;
    my %counts;
   
    for (my $i = 0; $i < $length; $i++) {
        for (my $j = 0; $j < scalar $nums->[$i]->@*; $j++) {
            $counts{$nums->[$i]->[$j][0]} += $nums->[$i]->[$j][1];
        }
    }

    push @items, [$_,$counts{$_}] foreach (sort keys %counts);
     
    return \@items;
}

for my $elements (@examples) {
    my $mi = merge_items $elements;

    print 'Input : ';
    for (my $i = 0; $i < scalar @$elements; $i++) {
        printf "%s items%d = %s\n", ' ' x (8 * $i), $i+1, dump($elements->[$i])
    }
    say 'Output : ', dump(@$mi);
    say ' ';
}
