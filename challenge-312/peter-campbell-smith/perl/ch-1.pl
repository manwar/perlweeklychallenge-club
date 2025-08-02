#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-10
use utf8;     # Week 312 - task 1 - Minimum time
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

minimum_time('abc');
minimum_time('bza');
minimum_time('zjpc');
minimum_time('theweeklychallenge');
minimum_time('bbb');
minimum_time('aaaaa');

sub minimum_time {
	
	my ($string, $time, $at_char, $next_char, $left, $right);
	
	#initialise
	$string = shift;
	$time = 0;
	$at_char = 'a';
	
	# loop over chars
	for $next_char (split('', $string)) {
		
		# calc left and right move
		$left = (ord($next_char) - ord($at_char)) % 26;
		$right = (ord($at_char) - ord($next_char)) % 26;
		$time += ($left < $right ? $left : $right) + 1;
		$at_char = $next_char;
	}
	
	say qq[\nInput:  \$string = '$string'];
	say qq[Output: $time secs];
}
