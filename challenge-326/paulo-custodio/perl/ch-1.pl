#!/usr/bin/env perl

# Challenge 326
#
# Task 1: Day of the Year
# Submitted by: Mohammad Sajid Anwar
# You are given a date in the format YYYY-MM-DD.
#
# Write a script to find day number of the year that the given date represent.
#
#
# Example 1
# Input: $date = '2025-02-02'
# Output: 33
#
# The 2nd Feb, 2025 is the 33rd day of the year.
#
# Example 2
# Input: $date = '2025-04-10'
# Output: 100
#
# Example 3
# Input: $date = '2025-09-07'
# Output: 250

use Modern::Perl;
use POSIX qw(mktime);

@ARGV==1 or die "usage: $0 yyy-mm-dd\n";
my($y, $m, $d) = split /-/, $ARGV[0];
my $epoch = mktime(0, 0, 0, $d, $m - 1, $y - 1900);
my $yday = (localtime($epoch))[7] + 1;
say $yday;
