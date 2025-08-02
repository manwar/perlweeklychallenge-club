#!/usr/bin/env perl

# The Weekly Challenge 268 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/
#
# Task 2 - Number Game
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    [ 2, 5, 3, 4 ],
    [ 9, 4, 1, 3, 6, 4, 6, 1 ],
    [1, 2, 2, 3]
);

sub number_game {
    my $nums = shift;
    my @ints = sort @$nums;
    my $length = scalar @ints;
    my @result =(); 

    for (my $i = 0; $i < $length; $i+=2) {
        push @result,($ints[$i+1], $ints[$i])
    }

    return \@result;
}

for my $elements (@examples) {
    my $ng = number_game $elements;

    say 'Input : @nums = ', dump(@$elements);
    say 'Output : ', dump(@$ng);
    say ' ';
}
