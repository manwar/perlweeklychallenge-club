#!/usr/bin/env perl

# The Weekly Challenge 279 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
#
# Task 1 - Sort Letters
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {letters => ['R', 'E', 'P', 'L'], weights => [3, 2, 1, 4]},
    {letters => ['A', 'U', 'R', 'K'], weights => [2, 4, 1, 3]},
    {letters => ['O', 'H', 'Y', 'N', 'P', 'T'], weights => [5, 4, 2, 6, 1, 3]},

);

sub sort_letters {
    my $elements = shift;
    my @letters = $elements->{letters}->@*;
    my $length = scalar @letters;
    my @weights = $elements->{weights}->@*;
    my %temp;
    my $word;

    for (my $i = 0; $i < $length; $i++) {
       $temp{$weights[$i]} = [$i,$letters[$i]]
    }

    $word .= $letters[$temp{$_}[0]] foreach (sort keys %temp);

    return $word

}

for my $elements (@examples) {
    my $sl = sort_letters $elements;

    say 'Input : @letters = ', dump(@$elements{letters});
    say 'Input : @weights = ', dump(@$elements{weights});
    say 'Output : ', $sl;
    say ' ';
}
