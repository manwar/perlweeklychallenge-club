#!/usr/bin/env perl

# Challenge 347
#
# Task 1: Format Date
# Submitted by: Mohammad Sajid Anwar
# You are given a date in the form: 10th Nov 2025.
#
# Write a script to format the given date in the form: 2025-11-10 using the set below.
#
# @DAYS   = ("1st", "2nd", "3rd", ....., "30th", "31st")
# @MONTHS = ("Jan", "Feb", "Mar", ....., "Nov",  "Dec")
# @YEARS  = (1900..2100)
#
# Example 1
# Input: $str = "1st Jan 2025"
# Output: "2025-01-01"
#
# Example 2
# Input: $str = "22nd Feb 2025"
# Output: "2025-02-22"
#
# Example 3
# Input: $str = "15th Apr 2025"
# Output: "2025-04-15"
#
# Example 4
# Input: $str = "23rd Oct 2025"
# Output: "2025-10-23"
#
# Example 5
# Input: $str = "31st Dec 2025"
# Output: "2025-12-31"

use Modern::Perl;

@ARGV==3 or die "usage: $0 1st Feb 2025\n";
my($d, $m, $y) = @ARGV;
$d =~ s/\D//g;
my %months = (jan=>1, feb=>2, mar=>3, apr=>4, may=>5, jun=>6,
              jul=>7, aug=>8, sep=>9, oct=>10, nov=>11, dec=>12);
$m = $months{lc($m)};
say sprintf("%04d-%02d-%02d", $y, $m, $d);
