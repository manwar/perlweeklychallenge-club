#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-340/#TASK2
#
# Task 2: Ascending Numbers
# =========================
#
# You are given a string, $str, is a list of tokens separated by a single
# space. Every token is either a positive number consisting of digits 0-9 with
# no leading zeros, or a word consisting of lowercase English letters.
#
# Write a script to check if all the numbers in the given string are strictly
# increasing from left to right.
#
## Example 1
##
## Input: $str = "The cat has 3 kittens 7 toys 10 beds"
## Output: true
##
## Numbers 3, 7, 10 - strictly increasing.
#
#
## Example 2
##
## Input: $str = 'Alice bought 5 apples 2 oranges 9 bananas'
## Output: false
#
#
## Example 3
##
## Input: $str = 'I ran 1 mile 2 days 3 weeks 4 months'
## Output: true
#
#
## Example 4
##
## Input: $str = 'Bob has 10 cars 10 bikes'
## Output: false
#
#
## Example 5
##
## Input: $str = 'Zero is 0 one is 1 two is 2'
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We collect all numbers in an array. Then we just start at the
# beginning and check if each one is less than or equal than the
# previous one: If it is, we can return false. In the end, we can
# return true as all numbers were bigger than the previous one.

use v5.36;

ascending_numbers("The cat has 3 kittens 7 toys 10 beds");
ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas');
ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months');
ascending_numbers('Bob has 10 cars 10 bikes');
ascending_numbers('Zero is 0 one is 1 two is 2');

sub ascending_numbers($str) {
    say "Input: $str";
    my @numbers = grep { /^[0-9]+$/ } split / /, $str;
    my $start = -1;
    my $result = "true";
    foreach my $n (@numbers) {
        if($n <=  $start) {
            $result = "false";
            last;
        }
        $start = $n;
    }
    say "Output: $result";
}
