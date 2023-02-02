#!/usr/bin/env perl

use strict;
use warnings;

# Task 1: Consecutive Odds
# You are given an array of integers.
# Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.
#
# Example 1
# Input: @array = (1,5,3,6)
# Output: 1
#
# Example 2
# Input: @array = (2,6,3,5)
# Output: 0
#
# Example 3
# Input: @array = (1,2,3,4)
# Output: 0
#
# Example 4
# Input: @array = (2,3,5,7)
# Output: 1

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 3
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                 @input) != 0;

my $output = 0;
foreach my $i (0..$#input-2) {
    if (checkOdd($input[$i]) and
        checkOdd($input[$i+1]) and
        checkOdd($input[$i+2])
    ) {
        $output = 1;
        last;
    }
}
printf "Output: %d\n", $output;

sub checkOdd {
    return ($_[0] % 2);
}
