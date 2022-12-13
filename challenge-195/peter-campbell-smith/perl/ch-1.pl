#!/usr/bin/perl

# Peter Campbell Smith - 2022-12-12
# PWC 195 task 1

use v5.28;
use utf8;
use warnings;

# You are given a positive integer, $n > 0. Write a script to print the count of all special integers between 1 and $n.
# An integer is special when all of its digits are unique.

# Blog: https://pjcs-pwc.blogspot.com/2022/12/some-numbers-are-special-and-others-are.html

my (@tests, $test, $count, $j, $digit, $start);
@tests = (15, 34, 77, 123, 1234, 12345, 1000000, 5000000);

# loop over tests
say qq[\n--- METHOD 1 ---];
for $test (@tests) {
	
	# loop over 1 to $n
	$start = time;
	$count = 0;
	TEST: for $j (1 .. $test) {
		
		# check for 2 of each digit
		for $digit (0..9) {
			
			# don't count if digit repeated
			next TEST if $j =~ m|$digit.*$digit|;
		}
		
		# is good
		$count ++;
	}
	say qq[\nInput:  $test\nOutput: $count (] . (time - $start) . qq[ secs)];
}

# loop over tests
say qq[\n--- METHOD 2 ---];
for $test (@tests) {
	
	# loop over 1 to $n
	$start = time;
	$count = 0;
	$j = 0;
	
	while (1) {
		
		$j ++;
		last if $j > $test;
		if ($j =~ m|(.+?)(0+)$|) {
			$j = ($1 + 1) * 10 ** length($2) - 1 if unspecial($1);
		}
		$count ++ unless unspecial($j);	
	}
	say qq[\nInput:  $test\nOutput: $count (] . (time - $start) . qq[ secs)];
}

sub unspecial {
	
	# returns 0 if special, 1 if not
	return 1 if $_[0] =~ m|1.*1|;
	return 1 if $_[0] =~ m|2.*2|;
	return 1 if $_[0] =~ m|3.*3|;
	return 1 if $_[0] =~ m|4.*4|;
	return 1 if $_[0] =~ m|5.*5|;
	return 1 if $_[0] =~ m|6.*6|;
	return 1 if $_[0] =~ m|7.*7|;
	return 1 if $_[0] =~ m|8.*8|;
	return 1 if $_[0] =~ m|9.*9|;
	return 1 if $_[0] =~ m|0.*0|;

	return 0;
}
