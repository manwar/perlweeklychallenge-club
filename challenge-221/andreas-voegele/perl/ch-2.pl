#!/usr/bin/perl

# You are given an array of integers, @ints.  Write a script to find the
# length of the longest Arithmetic Subsequence in the given array.  A
# subsequence is an array that can be derived from another array by deleting
# some or none elements without changing the order of the remaining elements.
# A subsequence is arithmetic if ints[i + 1] - ints[i] are all the same value
# (for 0 <= i < ints.length - 1).

use 5.036;
use utf8;

use List::Util qw(reduce);

sub next_numbers ($acc, $distance, @ints) {
    my $a = $acc->[-1];
    while (@ints > 0) {
        my $b = shift @ints;
        if (abs $a - $b == $distance) {
            push @{$acc}, $b;
            $a = $b;
        }
    }
    return $acc;
}

sub subsequences ($acc, @ints) {
    if (@ints >= 2) {
        my $a = shift @ints;
        subsequences($acc, @ints);
        while (@ints > 0) {
            my $b = shift @ints;
            my $distance = abs $a - $b;
            push @{$acc}, next_numbers([$a, $b], $distance, @ints);
        }
    }
    return $acc;
}

sub arithmetic_subsequences (@ints) {
    return @{subsequences([], @ints)};
}

sub longest_length (@sequences) {
    my $longest_sequence = reduce { @{$a} > @{$b} ? $a : $b } @sequences;
    return scalar @{$longest_sequence};
}

say longest_length(arithmetic_subsequences(9, 4, 7, 2, 10));
say longest_length(arithmetic_subsequences(3, 6, 9, 12));
say longest_length(arithmetic_subsequences(20, 1, 15, 3, 10, 5, 8));
