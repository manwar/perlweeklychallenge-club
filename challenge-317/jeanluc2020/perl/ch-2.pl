#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-317/#TASK2
#
# Task 2: Friendly Strings
# ========================
#
# You are given two strings.
#
# Write a script to return true if swapping any two letters in one string match
# the other string, return false otherwise.
#
## Example 1
##
## Input: $str1 = "desc", $str2 = "dsec"
## Output: true
#
#
## Example 2
##
## Input: $str1 = "fuck", $str2 = "fcuk"
## Output: true
#
#
## Example 3
##
## Input: $str1 = "poo", $str2 = "eop"
## Output: false
#
#
## Example 4
##
## Input: $str1 = "stripe", $str2 = "sprite"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# There is a pretty simple solution to this problem that just needs
# to take care of a few corner cases.
# 1. If the length of the two strings doesn't match, we can return false
# 2. We walk both strings simultaneously. If the two strings happen to
#    be equal everywhere except for two places, and the characters in
#    those two places are just exchanged, we can return true
# 3. The missing corner case: if the two strings are actually the same,
#    but have at least one duplicate character, we can also return true. If
#    they are the same without duplicate characters, we can't swap two
#    characters to make the strings match, so we return false.

use v5.36;

friendly_strings("desc", "dsec");
friendly_strings("fuck", "fcuk");
friendly_strings("poo", "eop");
friendly_strings("stripe", "sprite");
friendly_strings("foo", "foo");
friendly_strings("bar", "bar");

sub friendly_strings($str1, $str2) {
    say "Input: '$str1', '$str2'";
    return say "Output: false" if length($str1) != length($str2);
    my @chars1 = split //, $str1;
    my @chars2 = split //, $str2;
    my $found_chars = {};
    my @diff = ();
    foreach my $i (0..$#chars1) {
        $found_chars->{$chars1[$i]}++;
        if($chars1[$i] ne $chars2[$i]) {
            push @diff, [$chars1[$i], $chars2[$i]];
        }
    }
    if(scalar(@diff) == 2) {
        if($diff[0]->[0] eq $diff[1]->[1] && $diff[0]->[1] eq $diff[1]->[0]) {
            say "Output: true";
        } else {
            say "Output: false";
        }
    } elsif (scalar(@diff) == 0) {
        foreach my $char (keys %$found_chars) {
            return say "Output: true" if $found_chars->{$char} > 1;
        }
        say "Output: false";
    } else {
        say "Output: false";
    }
}
