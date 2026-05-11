#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-373/#TASK2
#
# Task 2: List Division
# =====================
#
# You are given a list and a non-negative integer.
#
# Write a script to divide the given list into given non-negative integer equal
# parts. Return -1 if the integer is more than the size of the list.
#
## Example 1
##
## Input: @list = (1,2,3,4,5), $n = 2
## Output: ((1,2,3), (4,5))
##
## 5 / 2 = 2 remainder 1.
## The extra element goes into the first chunk.
#
## Example 2
##
## Input: @list = (1,2,3,4,5,6), $n = 3
## Output: ((1,2), (3,4), (5,6))
##
## 6 / 3 = 2 remainder 0.
#
## Example 3
##
## Input: @list = (1,2,3), $n = 2
## Output: ((1,2), (3))
#
## Example 4
##
## Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
## Output: ((1,2), (3,4), (5,6), (7,8), (9,10))
#
## Example 5
##
## Input: @list = (1,2,3), $n = 4
## Output: -1
#
## Example 6
##
## Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
## Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))
#
############################################################
##
## discussion
##
############################################################
#
# First we handle the case that $n is bigger than the amount of elements
# in the list.
# Then we calculate the amount of elements per part and the remainder for
# the division. We then run from 0 to $n - 1, calculating the correct sublist
# that we need to collect this time, considering whether we are still below
# the calculated remainder or not. If we are below that threshold, we collect
# the elements from index $i * ($m + 1), with $m being the number of elements for
# each sublist, up to ($i+1) * ($m + 1) - 1 - right before the next sublist's
# beginning. After the threshold, this becomes a sublist starting at index
# $i * $m + $r until ($i+1) * $m + $r - 1, So we calculate the sublists and
# add them to the result.
#
use v5.36;

list_division([1,2,3,4,5], 2);
list_division([1,2,3,4,5,6], 3);
list_division([1,2,3], 2);
list_division([1,2,3,4,5,6,7,8,9,10], 5);
list_division([1,2,3], 4);
list_division([72,57,89,55,36,84,10,95,99,35], 7);

sub list_division($list, $n) {
    say "Input: (" . join(", ", @$list) . "), $n";
    my @tmp = @$list;
    if($n > scalar(@tmp)) {
        return say "Output: -1";
    }
    my $m = int( scalar(@tmp) / $n); # how many elements we will see in each part
    my $r = scalar(@tmp) - ($m * $n); # how many elements to distribute extra
    my @result = ();
    foreach my $i (0..$n-1) {
        if($i < $r) {
            my @t = @tmp[ $i * ($m + 1).. ($i+1) * ($m + 1) - 1 ];
            push @result, [ @t ];
        } else {
            my @t = @tmp[ $i * $m + $r .. ($i+1) * $m + $r - 1];
            push @result, [ @t ];
        }
    }
    print "Output: (";
    foreach my $elem (@result) {
        print "(" . join(", ", @$elem) . "), ";
    }
    say ")";
}
