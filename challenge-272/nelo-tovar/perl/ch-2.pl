#!/usr/bin/env perl

# The Weekly Challenge 272 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/
#
# Task 2 - String Score
#

use strict;
use warnings;
use v5.28;

my @examples = ('hello', 'perl', 'raku');

sub string_score {
    my $str = shift;
    my $length = length($str) - 1;
    my $sum = 0;

    for (my $i = 0; $i < $length; $i++) {
        $sum += abs(ord(substr($str, $i, 1)) - ord(substr($str,$i + 1, 1)));
    }
     
    return $sum;
}

for my $elements (@examples) {
    my $ss = string_score $elements;

    say 'Input : $str = ', $elements;
    say 'Output : ', $ss;
    say ' ';
}
