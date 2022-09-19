#!/usr/bin/perl

# Peter Campbell Smith - 2022-08-01
# PWC 176 task 2

use v5.28;
use utf8;
use warnings;

# Write a script to find out all Reversible Numbers below 100. A number is said to be 
# reversible if sum of the number and its reverse has only odd digits.

# Blog: 

my ($j, $result);

for $j (10 .. 99) {
	$j =~ m|(\d)(\d)|;
	$result .= "$j, " unless (11 * ($1 + $2)) =~ m|[02468]|;
}

$result = substr($result, 0, -2);
say $1 while $result =~ m|(.{0,36})|g;
