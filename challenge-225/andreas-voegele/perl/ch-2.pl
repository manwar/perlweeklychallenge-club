#!/usr/bin/perl

# You are given an array of integers.  For each element calculate the the sums
# of the elements to the left and right.  Return the differences between these
# sums.

use 5.036;
use utf8;

use experimental qw(builtin for_list);

use builtin    qw(indexed);
use List::Util qw(sum0);

sub left_right_sum_diff (@ints) {
    my @differences;
    my $left_sum  = 0;
    my $right_sum = sum0 @ints;
    for my ($i, $n) (indexed @ints) {
        $right_sum -= $n;
        $differences[$i] = abs $left_sum - $right_sum;
        $left_sum += $n;
    }
    return @differences;
}

sub format_array (@array) {
    return '(' . join(', ', @array) . ')';
}

say format_array(left_right_sum_diff(10, 4, 8, 3));
say format_array(left_right_sum_diff(1));
say format_array(left_right_sum_diff(1, 2, 3, 4, 5));
