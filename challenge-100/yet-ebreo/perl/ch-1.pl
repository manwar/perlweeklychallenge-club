#! /usr/bin/perl

use strict;
use warnings;
use feature qw(say);
# You are given a time (12 hour / 24 hour).
# Write a script to convert the given time from 12 hour format to 24 hour format and vice versa.
# Ideally we expect a one-liner.
# Example 1:
# Input: 05:15 pm or 05:15pm
# Output: 17:15
# Example 2:
# Input: 19:15
# Output: 07:15 pm or 07:15pm

#one-liner? sure thing! :D
sub f { pop=~/:.. */&&sprintf"%02d%s",$`%12+12*($'?'pm'eq$':$`%12<1),$&.($`<12?'am':'pm')x!$' }

say &f('01:00 pm');
say &f('12:01 am');
say &f('12:00 pm');
say &f('12:00 am');
say &f('13:00');
say &f('00:00');
say &f('19:15');
