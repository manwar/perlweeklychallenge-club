#!/bin/env perl
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge Task 2
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#               Trapper Rain Water
#
#       AUTHOR: Lubos Kolouch
#==============================================================================
use strict;
use warnings;
use List::Util qw/max min/;

sub trapWater{

    my $arr =shift;

    my $n = scalar @$arr;
    my $left_max = 0;
    my $right_max = 0;

    my $water = 0;

    my $low = 0;
    my $high = $n - 1;

    while ($low <= $high) {
        if ($arr->[$low] < $arr->[$high]) {
            if ($arr->[$low] > $left_max) {
                $left_max = $arr->[$low];
            } else {
                $water += $left_max - $arr->[$low];
            }
            $low += 1;
        } else {
            if ($arr->[$high] > $right_max) {
                $right_max = $arr->[$high];
            } else {
                $water += $right_max - $arr->[$high];
            }
            $high -= 1;
        }
    }

    return $water;
}

use Test::More;

is(trapWater([2, 1, 4, 1, 2, 5]), 6);
is(trapWater([3, 1, 3, 1, 1, 5]), 6);

done_testing;
