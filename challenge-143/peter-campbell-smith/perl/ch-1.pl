#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-13
# PWC 143 task 1

use v5.20;
use warnings;
use strict;

# You are given a string, $s, containing mathematical expression.
# Write a script to print the result of the mathematical expression.

my ($test, @tests);

# inputs
@tests = ("10 + 20 - 5", "(10 + 20 - 5) * 2", "(12345 * 6789) / 23 + 1 / 77");

# eval will do it
for $test (@tests) {
	say qq[\nInput:  \$s = $test\nOutput: ] . eval($test);
}
