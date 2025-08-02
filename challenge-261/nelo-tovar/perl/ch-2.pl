#!/usr/bin/env perl

# The Weekly Challenge 261 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
#
# Task 2 - Multiply by Two
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {start => 3, ints => [5, 3, 6, 1, 12]},
    {start => 1, ints => [1, 2, 4, 3]},
    {start => 2, ints => [5, 6, 7]},
);

sub multiply_by_two {
    my $nums = shift;
    my $start = shift;

    $start *= 2 while (grep {$_ eq $start} @$nums);
     
    return $start;
}

for my $elements (@examples) {
    my $mbt = multiply_by_two($elements->{ints}, $elements->{start});

    say 'Input : @ints = ', dump($elements->{ints}), ' and $start = ', $elements->{start};
    say 'Output : ', $mbt;
    say ' ';
}
