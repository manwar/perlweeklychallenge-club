#!/usr/bin/perl
=com
You are given an array of positive integers.

Write a script to return the absolute difference between digit sum and element sum of the given array.


Example 1
Input: @ints = (1, 23, 4, 5)
Output: 18

Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18

Example 2
Input: @ints = (1, 2, 3, 4, 5)
Output: 0

Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0

Example 3
Input: @ints = (1, 2, 34)
Output: 27

Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27
=cut

use strict;
use warnings;

my @array = (1, 23, 4, 5);

my $sum = 0;
my $digit_sum = 0;

foreach (@array){
	$sum += $_;
	
	my @inside_arr;
	my $val = 0;
	if ($_ > 9){
		@inside_arr = split('', $_);
		foreach my $element (@inside_arr){ $digit_sum += $element; }
	} else {
		$digit_sum += $_;
	}
}
print "Sum: $sum\n";
print "Digit Sum: $digit_sum\n";
print "Absolute difference: | ". $sum ." - ". $digit_sum ." | => ". ($sum - $digit_sum);