#!/usr/bin/perl

# Peter Campbell Smith - 2021-09-06
# Perl weekly challenge 129 task #2

# You are given two linked list having single digit positive numbers.

# Write a script to add the two linked list and create a new linked 
# representing the sum of the two linked list numbers. The two linked 
# lists may or may not have the same number of elements.

use strict;
use warnings;

my ($L1, $L1_left, $L2, $L2_left, $L3, $one, $two, $carry, $sum, $units, $blanks1, $blanks2);

# given lists
$L1 = $L1_left =      '9 -> 2 -> 0 -> 0 -> 5 -> 0 -> 7 -> 0';
$L2 = $L2_left = '7 -> 9 -> 9 -> 0 -> 8 -> 3 -> 9 -> 7 -> 0';

# cycle back from the end of each list
$carry = 0;
$L3 = '';
while ($L1_left =~ m|\d| or $L2_left =~ m|\d| or $carry) {   # not finished yet
	$one = $two = 0;
	($L1_left, $one) = ($1, $2) if $L1_left =~ m|(.*)(\d)|;  # strip off last (remaining) digit of each list
	($L2_left, $two) = ($1, $2) if $L2_left =~ m|(.*)(\d)|;
	$sum = $one + $two + $carry;                      # add the two digits and any carryover
	$units = $sum % 10;                               # get new digit     
	$L3 = "$units -> $L3";							  # add it to the start of L3
	$carry = ($sum - $units) / 10;                    # and compute any carryover (can only be 0 or 1)
}

# line them up
$L3 =~ s|....$||;     # remove final ' -> '
$blanks1 = length($L3) - length($L1);
$blanks2 = length($L3) - length($L2);
print 'L1 = ' . (' ' x $blanks1) . $L1 . "\n" .
	  'L2 = ' . (' ' x $blanks2) . $L2 . "\n" .
	  "L3 = $L3\n";
