#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-11
# PWC 173 task 1

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');

# You are given a positive integer, $n. Write a script to find out if the given number is 
# an Esthetic Number. An esthetic number is one where successive digits differ by 1.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/aesthetics-and-fast-growing-sequence.html

my (@tests, $test, $not, $j, $digit, $next, $as, $diff, $old_diff);

@tests = (1234, 1235, 123345, 7654, 3210, 8642, 1345, 9090, 11111,
	'7654567898765432123456789', '7654567898765432123456788');

# we can assume lack of estheticism as soon as we find 2 successive digits not differing by 1
say qq[\nQuick result, abandoning search as soon as an unesthetic pair is found];

# loop over tests
for $test (@tests) {
	
	# loop over 2nd to last digits, comparing them with the preceding one
	$digit = substr($test, 0, 1);
	for $j (1 .. length($test) - 1) {
		$next = substr($test, $j, 1);
		
		# test for being esthetic and quit if not
		$not = abs($digit - $next) == 1 ? '' : ' not';
		last if $not;
		
		$digit = $next;
	}
	$as = $not ? qq[ as |$digit - $next| != 1] : '';
	say qq[$test is$not an esthetic number$as];	
}

# ... but to reproduce Mohammad's examples we need to continue to the bitter end
say qq[\nExact result, reproducing Mohammad's output];

# loop over tests
for $test (@tests) {
	$as = $not = '';
	
	# loop over 2nd to last digits, comparing them with the preceding one	
	$digit = substr($test, 0, 1);
	for $j (1 .. length($test) - 1) {
		$next = substr($test, $j, 1);
		$diff = abs($digit - $next);
		
		# now we need a = or != depending on whether this absolute difference matches the previous one
		if ($j != 1) {
			$as .= ($diff == $old_diff) ? '=' : '!=';
		}
		
		# and we need to show the two digits we are now comparing
		$as .= qq[ |$digit - $next| ];
		
		# and don't forget the 'not'
		$not = ' not' if ($diff != 1 or $not);
		$digit = $next;
		$old_diff = $diff;
	}
	$as .= $diff == 1 ? '= 1' : '!= 1';
	say qq[$test is$not an esthetic number as$as];	
}

	

