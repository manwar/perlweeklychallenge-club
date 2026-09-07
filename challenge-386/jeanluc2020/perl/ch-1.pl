#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-386/#TASK1
#
# Task 1: Reverse Base
# ====================
#
# You are given a string representing a number, and an integer specifying the
# base of that representation.
#
# Write a function to convert this string to an integer. (For bases greater
# than 10, use characters A-Z, a-z, + and / in that order.)
#
## Example 1
##
## Input: $num = "101010", $base = 2
## Output: 42
#
## Example 2
##
## Input: $num = "EEADEE", $base = 16
## Output: 15642094
#
## Example 3
##
## Input: $num = "755", $base = 8
## Output: 493
#
## Example 4
##
## Input: $num = "1BRJB", $base = 36
## Output: 2228519
#
## Example 5
##
## Input: $num = "7MyqL", $base = 64
## Output: 123456789
#
#
############################################################
##
## discussion
##
############################################################
#
# We create a list of possible digits. Then we calculate the number digit
# for digit:
# - multiply the current result by $base
# - look for the current character in the possible digits and add the
#   corresponding number to the result
# - we are done once we have handled all digits
#

use v5.36;

my $possible_digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\+/";
my @digits = split //, $possible_digits;

reverse_base("101010", 2);
reverse_base("EEADEE", 16);
reverse_base("755", 8);
reverse_base("1BRJB", 36);
reverse_base("7MyqL", 64);

sub reverse_base($num, $base) {
    say "Input: \$num = \"$num\", \$base = $base";
    my @num_digits = split //, $num;
    my $result = 0;
    foreach my $d (@num_digits) {
        foreach my $idx (0..$#digits) {
            if( $digits[$idx] eq $d ) {
                $result *= $base;
                $result += $idx;
                last;
            }
        }
    }
    say "Output: $result";
}
