#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-384/#TASK2
#
# Task 2: Special Binary Substrings
# =================================
#
# You are given a binary string.
#
# Write a script to return all non-empty substrings (distinct) that have the
# same number of 0’s and 1’s, and all the 0’s and all the 1’s in these
# substrings are grouped consecutively.
#
## Example 1
##
## Input: $binary = "0101"
## Output: ("01", "10")
#
## Example 2
##
## Input: $binary = "000111"
## Output: ("000111", "0011", "01")
#
## Example 3
##
## Input: $binary = "000011"
## Output:  ("0011", "01")
#
## Example 4
##
## Input: $binary = "10011100"
## Output: ("10", "0011", "01", "1100")
#
## Example 5
##
## Input: $binary = "00000"
## Output: ()
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible substrings of $binary, skip if we find
# one we already saw before, and then keep it if it is a special one.
# The special binary substrings are of even length, and either start
# with all 0s and end with all 1s or vice versa, with an equal
# amount of 0s and 1s.

use v5.36;

special_binary_substrings("0101");
special_binary_substrings("000111");
special_binary_substrings("000011");
special_binary_substrings("10011100");
special_binary_substrings("00000");

sub special_binary_substrings($binary) {
    say "Input: \"$binary\"";
    my @result = ();
    my $seen = {};
    my $len = length($binary);
    foreach my $start (0..$len-1) {
        foreach my $length (1..$len-$start) {
            my $str = substr($binary, $start, $length);
            next if $seen->{$str};
            if(is_special($str)) {
                push @result, $str;
                $seen->{$str} = 1;
            }
        }
    }
    say "Output: (" . join(", ", map {"\"$_\""} @result) . ")";
}

sub is_special($binary) {
    return 0 if length($binary) % 2;
    my $left = substr($binary, 0, length($binary)/2);
    my $right = substr($binary, length($binary)/2, length($binary)/2);
    if($left =~ m/^0+$/) {
        return 1 if $right =~ m/^1+$/;
    } elsif ($left =~ m/^1+$/) {
        return 1 if $right =~ m/^0+$/;
    }
    return 0;
}
