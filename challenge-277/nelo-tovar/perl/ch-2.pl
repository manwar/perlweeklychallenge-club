#!/usr/bin/env perl

# The Weekly Challenge 277 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
#
# Task 2 - Strong Pair
#

use strict;
use warnings;
use v5.28;
use List::Util qw /min uniq/;
use Data::Dump qw(dump);

my @examples = (
    [ 1, 2, 3, 4, 5 ],
    [ 5, 7, 1, 7],
);

sub strong_pair {
    my $elements = shift;
    my @ints = uniq @$elements;
    my $length = scalar @ints;
    my $count = 0;

     for (my $i = 0; $i < $length - 1; $i++) {
         for (my $j = $i + 1; $j < $length; $j++) {
             my $diff = abs($ints[$i] - $ints[$j]);
             $count++ if ( 0 < $diff < min $ints[$i], $ints[$j] );
         }
         
     }
    return $count;
}

for my $elements (@examples) {
    my $sp = strong_pair $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $sp;
    say ' ';
}
