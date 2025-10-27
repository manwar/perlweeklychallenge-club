#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/#TASK1
#
# Task 1: Array Form Compute
# ==========================
#
# You are given an array of integers, @ints and an integer, $x.
#
# Write a script to add $x to the integer in the array-form.
#
###   The array form of an integer is a digit-by-digit representation stored as
###   an array, where the most significant digit is at the 0th index.
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4), $x = 12
## Output: (1, 2, 4, 6)
#
#
## Example 2
##
## Input: @ints = (2, 7, 4), $x = 181
## Output: (4, 5, 5)
#
#
## Example 3
##
## Input: @ints = (9, 9, 9), $x = 1
## Output: (1, 0, 0, 0)
#
#
## Example 4
##
## Input: @ints = (1, 0, 0, 0, 0), $x = 9999
## Output: (1, 9, 9, 9, 9)
#
#
## Example 5
##
## Input: @ints = (0), $x = 1000
## Output: (1, 0, 0, 0)
#
############################################################
##
## discussion
##
############################################################
#
# We need to add from the end of the array, so we just reverse
# the array and the array we get out of splitting $x into digits.
# Then we add the current digits from both reverse arrays, plus any
# carry over that we get from the previous digits. We keep the last
# digit for our result array, and if there is a second digit, we keep
# it as our new carry over. In the end, if there is a carry over, but
# no more digits, we need to add this carry over to the result.

use v5.36;

array_form_compute([1, 2, 3, 4], 12);
array_form_compute([2, 7, 4], 181);
array_form_compute([9, 9, 9], 1);
array_form_compute([1, 0, 0, 0, 0], 9999);
array_form_compute([0], 1000);

sub array_form_compute($ints, $x) {
    say "Input: (" . join(", ", @$ints) . "), $x";
    my @rev_ints = reverse @$ints;
    my @rev_x = reverse split //, $x;
    my $carry = 0;
    my @result = ();
    while(@rev_ints or @rev_x) {
        my $tmp = $carry;
        $tmp += shift @rev_ints if @rev_ints;
        $tmp += shift @rev_x if @rev_x;
        if($tmp > 9) {
            $carry = int($tmp / 10);
        } else {
            $carry = 0;
        }
        unshift @result, $tmp % 10;
    }
    unshift @result, $carry if $carry;
    say "Output: (" . join(", ", @result) . ")";
}
