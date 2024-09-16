#!/usr/bin/env perl

# The Weekly Challenge 282 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
#
# Task 2 - Changing Keys
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw (uniq);

my @examples = ('pPeERrLl', 'rRr', 'GoO');

sub changing_keys {
    my @str = uniq(split(//, lc(shift)));

    return scalar @str - 1;
}

for my $elements (@examples) {
    my $ck = changing_keys $elements;

    say 'Input : str = ', $ck;
    say 'Output : ', $ck;
    say ' ';
}
