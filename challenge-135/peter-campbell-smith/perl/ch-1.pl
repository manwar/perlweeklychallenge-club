#!/usr/bin/perl

# Peter Campbell Smith - 2021-10-18
# PWC 135 task 1

use v5.20;
use warnings;
use strict;

# You are given an integer.

# Write a script find out the middle 3-digits of the given integer, if possible 
# otherwise throw sensible error.

my ($n, $length);

# input
print 'n: ';
$n = <>;
chomp($n);
say qq[\nInput:  $n];

# output
print 'Output: ';
$length = length($n);

if ($n !~ m|^\d+$|) {
	say 'not an integer';
	
} elsif ($length < 3) {
	say 'too short';
	
} elsif (($length & 1) == 0) {
	say 'even number of digits';
	
} else {   # valid number
	say substr($n, ($length - 3) / 2, 3);
}
