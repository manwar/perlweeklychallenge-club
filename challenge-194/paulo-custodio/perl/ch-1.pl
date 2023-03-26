#!/usr/bin/perl

# Challenge 194
#
# Task 1: Digital Clock
# Submitted by: Mohammad S Anwar
# You are given time in the format hh:mm with one missing digit.
#
# Write a script to find the highest digit between 0-9 that makes it valid time.
#
# Example 1
# Input: $time = '?5:00'
# Output: 1
#
# Since 05:00 and 15:00 are valid time and no other digits can fit in the missing place.
# Example 2
# Input: $time = '?3:00'
# Output: 2
# Example 3
# Input: $time = '1?:00'
# Output: 9
# Example 4
# Input: $time = '2?:00'
# Output: 3
# Example 5
# Input: $time = '12:?5'
# Output: 5
# Example 6
# Input: $time =  '12:5?'
# Output: 9

use Modern::Perl;

sub missing_digit {
    my($clock)=@_;
    $clock =~ /^[\d?]{2}:[\d?]{2}$/ or die "invalid format: $clock";
    if    ($clock =~ /^\?[0-3]/)        { return 2; }
    elsif ($clock =~ /^\?[4-9]/)        { return 1; }
    elsif ($clock =~ /^[0-1]\?/)        { return 9; }
    elsif ($clock =~ /^2\?/)            { return 3; }
    elsif ($clock =~ /^[3-9]/)          { die "invalid format: $clock"; }
    elsif ($clock =~ /^\d{2}:\?[0-9]/)  { return 5; }
    elsif ($clock =~ /^\d{2}:[0-5]\?/)  { return 9; }
    elsif ($clock =~ /^\d{2}:[6-9]/)    { die "invalid format: $clock"; }
    else                                { die "invalid format: $clock"; }
}

say missing_digit($ARGV[0]);
