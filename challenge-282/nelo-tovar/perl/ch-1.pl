#!/usr/bin/env perl

# The Weekly Challenge 282 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
#
# Task 1 - Good Integer
#

use strict;
use warnings;
use v5.28;

my @examples = (12344456, 1233334, 10020003);

sub good_integer {
    my $nums = shift;

    return ($nums =~ /((\d) \2{2,})/gx and length $1 == 3) ? $1 : -1;
}

for my $elements (@examples) {
    my $gi = good_integer $elements;

    say 'Input : @nums = ', $elements;
    say 'Output : ', $gi;
    say ' ';
}
