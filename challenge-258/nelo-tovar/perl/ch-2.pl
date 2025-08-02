#!/usr/bin/env perl

# The Weekly Challenge 258 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
#
# Task 2 - Sum of Values
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 2, 5, 9, 11, 3 ],
    [ 2, 5, 9, 11, 3 ],
    [ 2, 5, 9, 11, 3 ],
);

my @examples_k = ( 1, 2, 0);

sub sum_of_values {
    my $ints = shift;
    my $k = shift;
    my $length = scalar @$ints;
    my $sum = 0;

    for (my $i = 0; $i < $length; $i++) {
        my @bits = split(//, sprintf("%b", $i));
        my $one_bits_counter = grep {$_ eq 1} @bits;

        $sum += $ints->[$i] if ($one_bits_counter eq $k);
    }
     
    return $sum;
}

for (my $i = 0; $i < scalar @examples_k; $i++) {
    my $elements = $examples[$i];
    my $k = $examples_k[$i];
    my $sov = sum_of_values $elements, $k;

    say 'Input : @ints = ', dump(@$elements), ', $k = ', $k;
    say 'Output : ', $sov;
    say ' ';
}
