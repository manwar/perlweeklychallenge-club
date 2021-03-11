#!/usr/bin/perl

# Challenge 100
#
# TASK #1 > Fun Time
# Submitted by: Mohammad S Anwar
# You are given a time (12 hour / 24 hour).
#
# Write a script to convert the given time from 12 hour format to 24 hour format
# and vice versa.
#
# Ideally we expect a one-liner.
#
# Example 1:
# Input: 05:15 pm or 05:15pm
# Output: 17:15
# Example 2:
# Input: 19:15
# Output: 07:15 pm or 07:15pm

use strict;
use warnings;
use 5.030;
use Time::Piece;

@ARGV==1 or die "Usage: ch-1.pl time\n";
my $time = shift =~ s/\s+//gr;
if ($time =~ /AM|PM/i) {
    say Time::Piece->strptime($time, "%I:%M%P")->strftime("%H:%M");
}
else {
    say Time::Piece->strptime($time, "%H:%M")->strftime("%I:%M%P");
}
