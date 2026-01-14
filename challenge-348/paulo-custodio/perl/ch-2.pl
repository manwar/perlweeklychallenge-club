#!/usr/bin/env perl

# Challenge 348
#
# Task 2: Covert Time
# Submitted by: Mohammad Sajid Anwar
# You are given two strings, $source and $target, containing time in 24-hour time form.
#
# Write a script to convert the source into target by performing one of the following operations:
#
# 1. Add  1 minute
# 2. Add  5 minutes
# 3. Add 15 minutes
# 4. Add 60 minutes
# Find the total operations needed to get to the target.
#
#
# Example 1
# Input: $source = "02:30"
#        $target = "02:45"
# Output: 1
#
# Just one operation i.e. "Add 15 minutes".
#
# Example 2
# Input: $source = "11:55"
#        $target = "12:15"
# Output: 2
#
# Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".
#
# Example 3
# Input: $source = "09:00"
#        $target = "13:00"
# Output: 4
#
# Four operations of "Add 60 minutes".
#
# Example 4
# Input: $source = "23:45"
#        $target = "00:30"
# Output: 3
#
# Three operations of "Add 15 minutes".
#
# Example 5
# Input: $source = "14:20"
#        $target = "15:25"
# Output: 2
#
# Two operations, one "Add 60 minutes" and one "Add 5 minutes"

use Modern::Perl;

@ARGV==2 or die "Usage: $0 HH:MM HH:MM\n";

my $t1 = minutes($ARGV[0]);
my $t2 = minutes($ARGV[1]);
say num_ops($t1, $t2);

sub num_ops {
    my($t1, $t2) = @_;
    $t2 += minutes("24:00") if $t2 < $t1;
    my $count = 0;
    while ($t1 < $t2) {
        for my $delta (60, 15, 5, 1) {
            while ($t1 + $delta <= $t2) {
                $count++;
                $t1 += $delta;
            }
        }
    }
    return $count;
}

sub minutes {
    my($hhmm) = @_;
    my($h, $m) = split /:/, $hhmm;
    return $h*60+$m;
}
