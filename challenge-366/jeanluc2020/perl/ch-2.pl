#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/#TASK2
#
# Task 2: Valid Times
# ===================
#
# You are given a time in the form ‘HH:MM’. The earliest possible time is
# ‘00:00’ and the latest possible time is ‘23:59’. In the string time, the
# digits represented by the ‘?’ symbol are unknown, and must be replaced with a
# digit from 0 to 9.
#
# Write a script to return the count different ways we can make it a valid
# time.
#
## Example 1
##
## Input: $time = "?2:34"
## Output: 3
##
## 0 -> "02:34" valid
## 1 -> "12:34" valid
## 2 -> "22:34" valid
#
## Example 2
##
## Input: $time = "?4:?0"
## Output: 12
##
## Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
## Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)
##
## Total: 2 × 6 = 12
#
## Example 3
##
## Input: $time = "??:??"
## Output: 1440
##
## Hours: from 00 to 23 -> 24 possibilities
## Minutes: from 00 to 59 -> 60 possibilities
##
## Total: 24 × 60 = 1440
#
## Example 4
##
## Input: $time = "?3:45"
## Output: 3
##
## If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
## If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is valid
##
## Therefore: 0,1,2 are all valid -> 3 possibilities
#
## Example 5
##
## Input: $time = "2?:15"
## Output: 4
##
## Tens digit is 2, so hours can be 20-23
## Ones digit can be 0,1,2,3 (4 possibilities)
##
## Therefore: 4 valid times
#
############################################################
##
## discussion
##
############################################################
#
# If there are no "?" in $time, we check, if it is valid.
# If there are "?" in $time, we count all possible times that we
# get if we replace "?" for each possible digit 0..9 (recursively,
# so we catch all "?" in $time).
# There is no short circuit in case we use invalid digits in some places.
# The whole thing is not time critical enough to complicate the algorithm
# by optimizing.

use v5.36;

valid_times("?2:34");
valid_times("?4:?0");
valid_times("??:??");
valid_times("?3:45");
valid_times("2?:15");

sub valid_times($time) {
    say "Input: $time";
    my $count = 0;
    if($time =~ m/\?/) {
        foreach my $d (0..9) {
            $count += find_valid($time, $d);
        }
        say "Output: $count";
    } else {
        say is_valid($time) ? "Output: 1" : "Output: 0";
    }
}

sub find_valid($time, $d) {
    $time =~ s/\?/$d/;
    my $count = 0;
    if($time =~ m/\?/) {
        foreach my $d2 (0..9) {
            $count += find_valid($time, $d2);
        }
        return $count;
    } else {
        return is_valid($time);
    }
}

sub is_valid($time) {
    my ($h, $m) = split /:/, $time;
    return 1 if ($h >= 0 && $h <= 23 && $m >= 0 && $m <= 59);
    return 0;
}
