#!/usr/bin/env perl

# The Weekly Challenge 258 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
#
# Task 1 Count Even Digits Number
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 10, 1, 111, 24, 1000 ],
    [ 111, 1, 11111 ],
    [ 2, 8, 1024, 256 ],
);

sub count_even_digits_number {
    my $nums = shift;
    
    return grep {(length($_) % 2) eq 0} @$nums;
}

for my $elements (@examples) {
    my $cedn = count_even_digits_number $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $cedn;
    say ' ';
}
