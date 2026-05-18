#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-374/#TASK2
#
# Task 2: Largest Same-digits Number
# ==================================
#
# You are given a string containing 0-9 digits only.
#
# Write a script to return the largest number with all digits the same in the
# given string.
#
## Example 1
##
## Input: $str = "6777133339"
## Output: 3333
#
## Example 2
##
## Input: $str = "1200034"
## Output: 4
#
## Example 3
##
## Input: $str = "44221155"
## Output: 55
#
## Example 4
##
## Input: $str = "88888"
## Output: 88888
#
## Example 5
##
## Input: $str = "11122233"
## Output: 222
#
############################################################
##
## discussion
##
############################################################
#
# We create all substrings of all the same digits, then we sort
# this list and return the largest number from it.

use v5.36;

largest_same_digits_number("6777133339");
largest_same_digits_number("1200034");
largest_same_digits_number("44221155");
largest_same_digits_number("88888");
largest_same_digits_number("11122233");

sub largest_same_digits_number($str) {
    say "Input: \"$str\"";
    my @numbers = ();
    while(length($str)) {
        my $c = substr($str,0,1);
        $str =~ s/^($c*)//;
        push @numbers, $1;
    }
    my @sorted = sort {$b <=> $a} @numbers;
    say "Output: " . shift @sorted;
}
