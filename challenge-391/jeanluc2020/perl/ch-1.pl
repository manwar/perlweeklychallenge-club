#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-391/#TASK1
#
# Task 1: Array Median
# ====================
#
# You are given two sorted arrays.
#
# Write a script to merge the two given sorted arrays and return the median of
# the merged array.
#
## Example 1
##
## Input: @arr1 = (2), @arr2 = (4)
## Output: 3.0
##
## Merged array: (2,4)
## Median: (2+4)/2 => 3
#
## Example 2
##
## Input: @arr1 = (1,2,3), @arr2 = (7,8,9,10)
## Output: 7.0
##
## Merged array: (1,2,3,7,8,9,10)
## Length of merged array is 7, the 4th element is 7.
#
## Example 3
##
## Input: @arr1 = (), @arr2 = (10,20,30,40)
## Output: 25.0
##
## Merged array: (10,20,30,40)
## Median: (20+30)/2 => 25
#
## Example 4
##
## Input: @arr1 = (100), @arr2 = (1,2,3,4,5,6,7)
## Output: 4.5
##
## Merged array: (1,2,3,4,5,6,7,100)
## Median: (4+5)/2 => 4.5
#
## Example 5
##
## Input: @arr1 = (1,2,2), @arr2 = (2,2,3)
## Output: 2.0
##
## Merged array: (1,2,2,2,2,3)
## Median: (2+2)/2 => 2
#
############################################################
##
## discussion
##
############################################################
#
# First we merge the arrays by picking the smaller element at the
# beginning of each array until one of the arrays is empty, then
# we add the remaining elements from the other array. Since the
# input arrays are sorted, that new list will also be sorted.
# Then we calculated the median (middle element in case of an odd
# number of elements, and the average of the two middle elements
# in case of an even amount of elements).

use v5.36;

sub array_median($arr1, $arr2) {
    say "Input: [" . join(", ", @$arr1) . "], [" . join(", ", @$arr2) . "]";
    my @merged = ();
    while(scalar(@$arr1) and scalar(@$arr2)) {
        my $l = $arr1->[0];
        my $r = $arr2->[0];
        if($l < $r) {
            push @merged, $l;
            shift @$arr1;
        } else {
            push @merged, $r;
            shift @$arr2;
        }
    }
    if(scalar(@$arr1)) {
        push @merged, @$arr1;
    }
    if(scalar(@$arr2)) {
        push @merged, @$arr2;
    }
    my $elems = scalar(@merged);
    if($elems % 2) {
        say "Output: " . $merged[int($elems/2)];
    } else {
        my $tmp = int($elems/2);
        say "Output: " . (($merged[$tmp-1] + $merged[$tmp]) / 2);
    }
}


array_median([2], [4]);
array_median([1,2,3], [7,8,9,10]);
array_median([], [10,20,30,40]);
array_median([100], [1,2,3,4,5,6,7]);
array_median([1,2,2], [2,2,3]);
