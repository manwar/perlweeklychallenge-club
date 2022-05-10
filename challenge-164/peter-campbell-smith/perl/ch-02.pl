#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-09
# PWC 164 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to find the first 8 Happy Numbers in base 10. 
# A happy number is a number which eventually reaches 1 when 
# replaced by the sum of the square of each digit.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/palindromic-primes-and-moody-numbers.html

my ($test, $so_far, $i, @digits, $d, @seen, @sad, $result1, $result2, $indent, $found);

$found = 0;
@sad = ();

# loop in the hope that we find 8 happy numbers before 1000
TEST: for $test (1 .. 1000) {
	last if $found == 8;  # success!
	
	$indent = 0;
	$so_far = $test;   # this will be our running sum of squares
	@seen = ();        # these are sums already seen for this $test (indicating looping)
	$result1 = '';
	
	# now iterate over the adding the digits squares
	for $i (1 .. 10) {
		
		# split $so_far into digits
		@digits = split('', $so_far);
		
		# this is all stuff to format the output as per Mohammad's example
		$result1 .= qq[$so_far => ];
		$indent += length($so_far) + ($i == 1 ? 1 : 4);
		$result2 = (' ' x $indent) . qq[=> ];
		
		# now sum the square of the digits
		$so_far = 0;
		for $d (@digits) {
			$so_far += $d**2;
			
			# more formatting stuff
			$result1 .= qq[$d^2 + ];
			$result2 .= $d**2 . qq[ + ];
		}

		# more formatting stuff
		$result1 = substr($result1, 0, -2) . qq[\n] . 
				substr($result2, 0, -2) . qq[\n] . (' ' x $indent) . '=> ';
		
		# if $so_far is 1 we are happy!
		if ($so_far == 1) {
			say qq[\n${result1}1];
			$found ++;
			next TEST;
			
		# if $so_far has been seen already for this $test or is already known to be $sad
		# then we're in a loop and $test is sad
		} elsif ($seen[$so_far] or $sad[$so_far]) {
			$sad[$so_far] = 1;
			next TEST;
		}

		# if neither of the above are true then we note that we've seen $seen and keep going
		$seen[$so_far] = 1;
	}
}
	

		
		