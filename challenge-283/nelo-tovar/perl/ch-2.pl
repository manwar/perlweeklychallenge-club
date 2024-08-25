#!/usr/bin/env perl

# The Weekly Challenge 283 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
#
# Task 2 - Digit Count Value
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 1, 2, 1, 0 ],
    [ 0, 3, 0],
);

sub digit_count_value {
    my $nums = shift;
    my $length = scalar @$nums;

    for (my $i = 0; $i < $length; $i++) {
         my $count = scalar grep {$_ eq $i} @$nums;

         return 'false' if ($count ne @$nums[$i])
    }
         
    return 'true';
}

for my $elements (@examples) {
    my $dgv = digit_count_value $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $dgv;
    say ' ';
}
