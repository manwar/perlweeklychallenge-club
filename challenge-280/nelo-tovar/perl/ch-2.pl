#!/usr/bin/env perl

# The Weekly Challenge 280 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
#
# Task 2 - Count Asterisks
#

use strict;
use warnings;
use v5.28;

my @examples = ("p|*e*rl|w**e|*ekly|", "perl", "th|ewe|e**|k|l***ych|alleng|e");

sub count_asterisks {
    my $string = shift;

    $string =~ s/\|.*?\|//sg;

    return $string =~ tr/*//;
}

for my $elements (@examples) {
    my $ca = count_asterisks $elements;

    say 'Input : @nums = ', $elements;
    say 'Output : ', $ca;
    say ' ';
}
