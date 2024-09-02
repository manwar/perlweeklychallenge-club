#!/usr/bin/env perl

# The Weekly Challenge 284 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
#
# Task 2 - Relative Sort
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    [ [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6] ],
    [ [3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2] ],
    [ [3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2] ],
);

sub relative_sort {
    my $e = shift;
    my @list1 = $e->[0]->@*;
    my @list2 = $e->[1]->@*;
    my @sorted;

    for my $n (@list2) {
       push @sorted, grep { $_ == $n } @list1;
       @list1 = grep { $_ != $n } @list1;
    }

    push @sorted, sort @list1;

    return \@sorted
}

for my $elements (@examples) {
    my $rs = relative_sort $elements;

    say 'Input : @list1 = ', dump($elements->[0]);
    say '        @list2 = ', dump($elements->[1]);
    say 'Output : ', dump($rs);
    say ' ';
}
