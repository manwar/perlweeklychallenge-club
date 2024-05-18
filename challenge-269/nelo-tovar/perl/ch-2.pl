#!/usr/bin/env perl

# The Weekly Challenge 269 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
#
# Task 2 - Distribute Elements
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 2, 1, 3, 4, 5 ],
    [ 3, 2, 4],
    [ 5, 4, 3 ,8],
);

sub distribute_elements {
    my $nums = shift;
    my @ints = @$nums;
    my @arr1 = ();
    my @arr2 = ();

    push @arr1, shift @ints;
    push @arr2, shift @ints;

    foreach my $n (@ints) {
        if ($arr1[-1] > $arr2[-1]) {
            push @arr1, $n
        }else{
            push @arr2, $n
        }
    }

    return [@arr1,@arr2];
}

for my $elements (@examples) {
    my $de = distribute_elements $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', dump(@$de);
    say ' ';
}
