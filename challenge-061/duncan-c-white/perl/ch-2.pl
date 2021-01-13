#!/usr/bin/perl
# 
# Task 2: "IPv4 Partition
# 
# You are given a string containing only digits (0..9). The string should
# have between 4 and 12 digits.
# 
# Write a script to print every possible valid IPv4 address that can be
# made by partitioning the input string.
# 
# For the purpose of this challenge, a valid IPv4 address consists of four
# 'octets' i.e. A, B, C and D, separated by dots (.).
# 
# Each octet must be between 0 and 255, and must not have any leading
# zeroes. (e.g., 0 is OK, but 01 is not.)
# 
# Example
# 
# Input: 25525511135
# 
# Output:
# 
# 255.255.11.135
# 255.255.111.35
# "
# 
# My notes: sounds quite straightforward, nice problem.  BTW, the last
# rule means that the whole string can't start with a 0, surely.  After
# briefly trying a regex-based option, do this the obvious way: 3 nested
# for loops with constraints, each setting the width of the Nth octet,
# with the 4th octet being the rest of the string.
#

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
#use Data::Dumper;

die "Usage: make-ip-addresses DIGITSTRING\n" if @ARGV != 1;
my $d = shift;
die "bad digit string $d, should be 4-12 digits\n" unless $d =~ /^\d{4,12}$/;
die "bad digit string $d, can't start with a 0\n" if $d =~ /^0/;

# first octet can be 1, 2 or 3 digits long
foreach my $firstlen (1..3)
{
	my $firstoctet = substr($d,0,$firstlen);
	next if $firstoctet > 255;
	#say "first: $firstoctet";

	# second octet can be 1, 2 or 3 digits long; not starting with 0
	foreach my $secondlen (1..3)
	{
		my $secondoctet = substr($d,$firstlen,$secondlen);
		next if $secondoctet == 0 || $secondoctet > 255;
		#say "second: $secondoctet";

		# third octet can be 1, 2 or 3 digits long; not starting with 0
		foreach my $thirdlen (1..3)
		{
			my $thirdoctet = substr($d,$firstlen+$secondlen,$thirdlen);
			next if $thirdoctet == 0 || $thirdoctet > 255;
			#say "third: $thirdoctet";

			# fourth octet: rest of string
			my $fourthoctet = substr($d,$firstlen+$secondlen+$thirdlen);
			next if $fourthoctet == 0 || $fourthoctet > 255;
			say "$firstoctet.$secondoctet.$thirdoctet.$fourthoctet";
		}
	}
}
