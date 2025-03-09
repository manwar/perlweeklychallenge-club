#!/usr/bin/perl

# Task 2: Group Digit Sum
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, made up of digits, and an integer, $int, which is less than the length of the given string.
# 
# Write a script to divide the given string into consecutive groups of size $int (plus one for leftovers if any). Then sum the digits of each group, and concatenate all group sums to create a new string. If the length of the new string is less than or equal to the given integer then return the new string, otherwise continue the process.
# 
# Example 1
# Input: $str = "111122333", $int = 3
# Output: "359"
# 
# Step 1: "111", "122", "333" => "359"
# Example 2
# Input: $str = "1222312", $int = 2
# Output: "76"
# 
# Step 1: "12", "22", "31", "2" => "3442"
# Step 2: "34", "42" => "76"
# Example 3
# Input: $str = "100012121001", $int = 4
# Output: "162"
# 
# Step 1: "1000", "1212", "1001" => "162"

use strict;
use warnings;
use List::Util qw(sum);

sub reduce_string {
	my ($string, $number) = @_;
	my @strings;
	print "groups: ";
	foreach my $chunk (unpack("(A$number)*", $string)) {
		print "$chunk ";
		my $local_sum = sum split("", $chunk);
		push @strings, $local_sum;
	}
	print "\ngroups with their sums: @strings\n";
	my $new_string = join("", @strings);
	if (length($new_string) > $number) {
		print "new string: ".$new_string."\n";
		$new_string = reduce_string($new_string, $number);
	}
	return $new_string;
}

print "Enter a random number of random length: ";
my $string = <STDIN>;
print "Enter any number smaller than the number of digits in previous number: ";
my $number = <STDIN>;
print("Final reduced string: " . reduce_string($string, $number) . "\n");


