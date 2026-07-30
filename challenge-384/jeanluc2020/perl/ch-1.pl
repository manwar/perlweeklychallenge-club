#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-384/#TASK1
#
# Task 1: Base N
# ==============
#
# You are given a number and a base integer.
#
# Write a script to convert the given number in the given base integer.
#
## Example 1
##
## Input: $num = 42, $base = 2
## Output: 101010
#
## Example 2
##
## Input: $num = 15642094, $base = 16
## Output: EEADEE
#
## Example 3
##
## Input: $num = 493, $base = 8
## Output: 755
#
## Example 4
##
## Input: $num = 2228519, $base = 36
## Output: 1BRJB
##
## Base 36 uses numbers 0-9 and letters A-Z.
#
## Example 5
##
## Input: $num = 123456789, $base = 64
## Output: 7MyqL
##
## Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)
#
############################################################
##
## discussion
##
############################################################
#
# We create a list of possible digits. Then we calculate the digits one by one:
# - the next digit (from the rigth) is the ($num % $base)th possible digit
# - then we get the integer part of $num / $base to find the remainder for the
#   next step
# - we are done once we hit 0.
#

use v5.36;

my $possible_digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!\"#\$\%*+-./:;,<>=?";
my @digits = split //, $possible_digits;

base_n(42, 2);
base_n(15642094, 16);
base_n(493, 8);
base_n(2228519, 36);
base_n(123456789, 64);

sub base_n($num, $base) {
    say "Input: $num, $base";
    my $result = "";
    while($num > 0) {
        my $digit = $num % $base;
        $num = int($num / $base);
        $result = $digits[$digit] . $result;
    }
    say "Output: $result";
}
