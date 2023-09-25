#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub duplicate_zeros(@ints) {
    my @d;
    for my $int (@ints) {
        push @d, ($int) x (1 + (0 == $int));
        last if @d > @ints
    }
    return [@d[0 .. $#ints]]
}

sub duplicate_zeros_laconic(@ints) {
    [(map +($_) x (1 + (0 == $_)), @ints)[0 .. $#ints]]
}

use Test2::V0;
plan 3 + 3;

for my $d (*duplicate_zeros{CODE}, *duplicate_zeros_laconic{CODE}) {
    is $d->(1, 0, 2, 3, 0, 4, 5, 0), [1, 0, 0, 2, 3, 0, 0, 4], 'Example 1';
    is $d->(1, 2, 3), [1, 2, 3], 'Example 2';
    is $d->(0, 3, 0, 4, 5), [0, 0, 3, 0, 0], 'Example 3';
}
