#!/usr/bin/perl

# Peter Campbell Smith - 2022-12-06
# PWC 194 task 2

use v5.28;
use utf8;
use warnings;

# You are given a string made of alphabetic characters only, a-z. Write a script to determine whether removing only 
# one character can make the frequency of the remaining characters the same.

# Blog: https://pjcs-pwc.blogspot.com/2022/12/completing-time-and-levelling-letters.html

my (@tests, $test, @chars, $char, %freq, $max_freq, $max_char, $good, $others_equal, $singles);

@tests = ('abbc', 'xyzyyxz', 'xzxz', 'aaaaa', 'aaabbcc', 'aabbccc', 'x', 'abbcc', 'abc',
	'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz' . 'q' . 'abcdefghijklmnopqrstuvwxyz' );

for $test (@tests) {
	%freq = ();
	$max_freq = 0;
	
	# create $freq{'x'} as frequency of 'x' in string
	@chars = split(//, $test);
	for $char (@chars) {
		$freq{$char} ++;
	}
	
	# find the maximum frequency and the (or one of the) characters having that frequency
	for $char (keys %freq) {
		if ($freq{$char} > $max_freq) {
			$max_freq = $freq{$char};
			$max_char = $char;
		}
	}
	
	# for each character that isn't $max_char, the frequency must be $max_freq - 1
	$good = 1;
	$others_equal = 1;
	$singles = '';
	for $char (sort keys %freq) {
		$good = 0 if ($char ne $max_char and $freq{$char} != $max_freq - 1);
		
		# but there is a special case where one char appears once and the rest appear with equal frequency (eg abbcc)
		if ($freq{$char} == 1) {
			$singles .= qq['$char' or ] if $freq{$char} == 1;
		} else {
			$others_equal &= $freq{$char} == $max_freq;
		}
	}
	
	# report result
	if ($good) {
		say qq[\nInput:  $test\nOutput: 1 as removal of one '$max_char' leaves the remaining frequencies equal];
	
	} elsif ($singles and $others_equal) {
		$singles =~ s|....$||;
		say qq[\nInput:  $test\nOutput: 1 as removal of $singles leaves the remaining frequencies equal];

	} else {
		say qq[\nInput:  $test\nOutput: 0 as no single removal leaves the remaining frequencies equal];
	}

}

