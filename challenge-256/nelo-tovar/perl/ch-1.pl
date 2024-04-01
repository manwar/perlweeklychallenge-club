#!/usr/bin/env perl

# The Weekly Challenge 256 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
#
# Task 1 - Maximum Pairs
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    ["ab", "de", "ed", "bc"],
    ["aa", "ba", "cd", "ed"],
    ["uv", "qp", "st", "vu", "mn", "pq"]
);

sub maximum_pairs {
    my $words = shift;
    my $length = scalar @$words;
    my $max = 0;

    for (my $i = 0; $i < $length - 1; $i++) {
        for (my $j = $i + 1; $j < $length; $j++) {
            my $reverse = join('', reverse(split(//, @$words[$j])));
            
            if (@$words[$i] eq $reverse){
                $max++;
                last
            }
        }
    }

    return $max
}

for my $elements (@examples) {
    my $mp = maximum_pairs $elements;

    say 'Input : @words = ', dump(@$elements);
    say 'Output : ', $mp;
    say ' ';
}
