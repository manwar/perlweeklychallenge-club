#!/usr/bin/env perl

# The Weekly Challenge 273 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
#
# Task 2 - B After A
#

use strict;
use warnings;
use v5.28;

my @examples = ( 'aabb', 'abab', 'aaa', 'bbb');

sub b_after_a {
    my $str = shift;

    return ( $str =~ /bb|^b+$/ ? 'true' : 'false');
}

for my $element (@examples) {
    my $baa = b_after_a $element;

    printf "Input  : str = '%s'\n", $element;
    printf "Output : %s\n", $baa;
    say ' ';
}
