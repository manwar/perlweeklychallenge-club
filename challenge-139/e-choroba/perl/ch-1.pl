#!/usr/bin/perl
use warnings;
use strict;

sub jort_sort {
    my @array = @_;

    my @sorted = @array;
    my $i = 0;
    while ($i != $#sorted) {
        if ($sorted[$i] <= $sorted[ $i + 1 ]) {
            ++$i;
        } else {
            @sorted[$i + 1, $i] = @sorted[$i, $i + 1];
            --$i unless 0 == $i;
        }
    }

    for my $i (0 .. $#array) {
        return 0 unless $array[$i] == $sorted[$i];
    }
    return 1
}

use Test2::V0;
plan 2;

is jort_sort(1, 2, 3, 4, 5), 1, 'Example 1';
is jort_sort(1, 3, 2, 4, 5), 0, 'Example 2';
