#!/usr/bin/env perl

# The Weekly Challenge 280 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
#
# Task 1 - Twice Appearance
#

use strict;
use warnings;
use v5.28;

my @examples = ("acbddbca", "abccd", "abcdabbb");

sub twice_appearance {
    my @letters = split(//,shift);
    my %temp;

    foreach my $letter (@letters) {
        return $letter if ($temp{$letter});

        $temp{$letter} = 1;
    }

    return ' '
}

for my $elements (@examples) {
    my $ta = twice_appearance $elements;

    say 'Input : $str = ', $elements;
    say 'Output : ', $ta;
    say ' ';
}
