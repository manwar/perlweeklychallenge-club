#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-314/#TASK1
#
# Task 1: Equal Strings
# =====================
#
# You are given three strings.
#
# You are allowed to remove the rightmost character of a string to make all equals.
#
# Write a script to return the number of operations to make it equal otherwise -1.
#
## Example 1
##
## Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
## Output: 2
##
## Operation 1: Delete "c" from the string "abc"
## Operation 2: Delete "b" from the string "abb"
#
## Example 2
##
## Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
## Output: -1
#
## Example 3
##
## Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
## Output: 3
#
############################################################
##
## discussion
##
############################################################
#
# At first, we check what's the minimum and maximum length of all
# given strings. If these lengths differ by more than one, then
# we can return -1 right away. Otherwise, if min and max are equal,
# then all strings are of the same length. If they are all equal,
# then we can return 0. Otherwise, we need to fall through to removing
# the last character of each string. We do this by reducing min by 1
# and then falling through to the handling of cases were the min and
# max lengths differ by exactly one.
# In this case, we remove the last character if the length is not
# equal to min and count this as an operation to make strings equal.
# if in the end, all elements are the same, we return the number of
# operations. Otherwise, we couldn't make all strings equal and return -1.

use v5.36;
use List::Util qw(min max);

equal_strings("abc", "abb", "ab");
equal_strings("ayz", "cyz", "xyz");
equal_strings("yza", "yzb", "yzc");

sub equal_strings(@strings) {
    say "Input: " . join(", ", @strings);
    my $tmp = {};
    my $min = min map {length($_)} @strings;
    my $max = max map {length($_)} @strings;
    if($max - $min > 1) {
        return say "Output: -1";
    }
    if($max == $min) {
        map { $tmp->{$_}++ } @strings;
        if(scalar(keys(%$tmp)) > 1) {
            $min--;
        } else {
            return say "Output: 0";
        }
    }
    $tmp = {};
    my $count = 0;
    foreach my $elem (@strings) {
        if(length($elem) > $min) {
            $elem =~ s/.$//;
            $count++
        }
        $tmp->{$elem}++;
    }
    if(scalar(keys(%$tmp)) == 1) {
        say "Output: $count";
    } else {
        say "Output: -1";
    }
}
