#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-348/#TASK2
#
# Task 2: Covert Time
# ===================
#
# You are given two strings, $source and $target, containing time in 24-hour time form.
#
# Write a script to convert the source into target by performing one of the following operations:
#
# 1. Add  1 minute
# 2. Add  5 minutes
# 3. Add 15 minutes
# 4. Add 60 minutes
#
# Find the total operations needed to get to the target.
#
# Example 1
#
# Input: $source = "02:30"
#        $target = "02:45"
# Output: 1
#
# Just one operation i.e. "Add 15 minutes".
#
#
# Example 2
#
# Input: $source = "11:55"
#        $target = "12:15"
# Output: 2
#
# Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".
#
#
# Example 3
#
# Input: $source = "09:00"
#        $target = "13:00"
# Output: 4
#
# Four operations of "Add 60 minutes".
#
#
# Example 4
#
# Input: $source = "23:45"
#        $target = "00:30"
# Output: 3
#
# Three operations of "Add 15 minutes".
#
#
# Example 5
#
# Input: $source = "14:20"
#        $target = "15:25"
# Output: 2
#
# Two operations, one "Add 60 minutes" and one "Add 5 minutes"
#
############################################################
##
## discussion
##
############################################################
#
# We turn the hours:minutes into minutes since the start of the day.
# Then we calculate the diff: If the source is bigger than the target,
# the diff is the minutes until end of day plut the minutes of target,
# in the other case it's just the diff from source to target.
# Then we check how many times we can fill 60 minutes into this diff,
# then how many additional 15 minutes, then how many additional 5 minutes,
# then how many single minutes.

use v5.36;

my $minutes_per_day = 24 * 60;

convert_time("02:30", "02:45");
convert_time("11:55", "12:15");
convert_time("09:00", "13:00");
convert_time("23:45", "00:30");
convert_time("14:20", "15:25");

sub convert_time($source, $target) {
    say "Input: \$source = '$source', \$target = '$target'";
    my ($h, $m) = split /:/, $source;
    $h =~ s/^0//;
    $m =~ s/^0//;
    my $minutes_source = $h * 60 + $m;
    ($h, $m) = split /:/, $target;
    $h =~ s/^0//;
    $m =~ s/^0//;
    my $minutes_target = $h * 60 + $m;
    if($minutes_source == $minutes_target) {
        return say "Output: 0";
    }
    my $diff = $minutes_target - $minutes_source;
    if($minutes_source > $minutes_target) {
        $diff = $minutes_target + $minutes_per_day - $minutes_source;
    }
    my $count = 0;
    while($diff >= 60) {
        $diff -= 60;
        $count++;
    }
    while($diff >= 15) {
        $diff -= 15;
        $count++;
    }
    while($diff >= 5) {
        $diff -= 5;
        $count++;
    }
    $count += $diff;
    say "Output: $count";
}
