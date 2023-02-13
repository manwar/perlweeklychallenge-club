#!/usr/bin/env perl

# Task 2: Widest Valley
# Submitted by: E. Choroba
# 
# Given a profile as a list of altitudes, return the leftmost widest valley. A valley is defined as a subarray of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing. Either part can be empty.
# 
# Example 1
# Input: 1, 5, 5, 2, 8
# Output: 5, 5, 2, 8
# 
# Example 2
# Input: 2, 6, 8, 5
# Output: 2, 6, 8
# 
# Example 3
# Input: 9, 8, 13, 13, 2, 2, 15, 17
# Output: 13, 13, 2, 2, 15, 17
# 
# Example 4
# Input: 2, 1, 2, 1, 3
# Output: 2, 1, 2
# 
# Example 5
# Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
# Output: 3, 3, 2, 1, 2, 3, 3

use strict;
use warnings;
use List::Util qw( min max );

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                 @input) != 0;

my @valley;
foreach my $min (0..$#input) {
    foreach my $max (reverse($min..$#input)) {
        my @subarray = map { $input[$_] }
                         ($min..$max);
        push @valley, [(scalar @subarray),
                       $min,
                       \@subarray
                      ]
            if check_valley(\@subarray);
    }
}
my $widest = max map { $_->[0] }
                   @valley;
my $leftmost = min map { $widest == $_->[0] ? $_->[1] : () }
                     @valley;
printf "%s\n", join ', ', map { $input[$_] }
                            ($leftmost..$leftmost+$widest-1);

exit 0;

sub check_valley {
    my $array = shift;
    my $index_left = 0;
    my $index_right = (scalar @$array)-1;

    foreach my $index (1..(scalar @$array)-1) {
        last if $array->[$index_left] < $array->[$index];
        $index_left = $index;
    }
    foreach my $index (reverse $index_left..(scalar @$array)-2) {
        last if $array->[$index_right] < $array->[$index];
        $index_right = $index;
    }

    return ($index_right == $index_left)
        ? 1
        : 0;
}
