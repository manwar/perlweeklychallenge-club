#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-375/#TASK2
#
# Task 2: Find K-Beauty
# =====================
#
# You are given a number and a digit (k).
#
# Write a script to find the K-Beauty of the given number. The K-Beauty of an
# integer number is defined as the number of substrings of given number when it
# is read as a string has length of ‘k’ and is a divisor of given number.
#
## Example 1
##
## Input: $num = 240, $k = 2
## Output: 2
##
## Substring with length 2:
## 24: 240 is divisible by 24
## 40: 240 is divisible by 40
#
## Example 2
##
## Input: $num = 1020, $k = 2
## Output: 3
##
## Substring with length 2:
## 10: 240 is divisible by 10
## 02: 240 is divisible by 2
## 20: 240 is divisible by 20
#
## Example 3
##
## Input: $num = 444, $k = 2
## Output: 0
##
## Substring with length 2:
## First "44": 444 is not divisible by 44
## Second "44": 444 is not divisible by 44
#
## Example 4
##
## Input: $num = 17, $k = 2
## Output: 1
##
## Substring with length 2:
## 17: 17 is divisible by 17
#
## Example 5
##
## Input: $num = 123, $k = 1
## Output: 2
##
## Substring with length 1:
## 1: 123 is divisible by 1
## 2: 123 is not divisible by 2
## 3: 123 is divisible by 3
#
############################################################
##
## discussion
##
############################################################
#
# We just create all substrings of length k and count them if $num
# is divisible by that number.

use v5.36;

find_k_beauty(240, 2);
find_k_beauty(1020, 2);
find_k_beauty(444, 2);
find_k_beauty(17, 2);
find_k_beauty(123, 1);

sub find_k_beauty($num, $k) {
    say "Input: num = $num, k = $k";
    my $n = $num;
    my $k_beauty = 0;
    while(length($n) >= $k) {
        my $s = substr($n, 0, $k);
        $s =~ s/^0*//;
        $n = substr($n, 1);
        $k_beauty++ unless $num % $s;
    }
    say "Output: $k_beauty";
}
