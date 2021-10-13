#!/usr/bin/perl

# Peter Campbell Smith - 2021-10-13
# PWC 134 task 1

use v5.20;
use warnings;

# Write a script to generate first 5 Pandigital Numbers in base 10.
# A pandigital number is an integer that in a given base has among its significant 
# digits each digit used in the base at least once.

# The first such number is 1023456789 as we can't start with 0 which isn't 'significant'.
#
# The simplest way to find the next 4 is simply to test every subsequent integer
# until all 5 are found.  Even if you are looking for the first 1000 pandigitals
# this completes in a few seconds.

my ($test, $count, $limit);

$limit = 5;        # how many do we want
$count = 0;		   # how many have we found

# start with the known first one and test subsequent integers
$test = 1023456789;
while (1) {
	if ($test =~ m|0| and $test =~ m|1| and $test =~ m|2| and $test =~ m|3| and $test =~ m|4|
		and $test =~ m|5| and $test =~ m|6| and $test =~ m|7| and $test =~ m|8| and $test =~ m|9|) {
		say $test;
		last if ++$count == $limit;
	}
	$test ++;
}
