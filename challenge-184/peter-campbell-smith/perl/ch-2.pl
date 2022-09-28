#!/usr/bin/perl

# Peter Campbell Smith - 2022-09-28
# PWC 184 task 2

use v5.28;
use utf8;
use warnings;

# You are given list of strings containing 0-9 and a-z separated by spaces only.
# Write a script to split the data into two arrays, one for integers and one for letters only.

# Blog: 

my (@lists, $list, $char, $first, $second, $output, $j);

# inputs
@lists = (qq['a 1 2 b 0', '3 c 4 d'], qq['1 2', 'p q r', 's 3', '4 5 t']);

for $list (@lists) {
	say qq[\nInput:  $list];
	$first = $second = '[';
	
	# loop over characters in list
	while ($list =~ m|(.)|g) {
		$char = $1;
		
		# a digit, append it and a comma to $first
		if ($char =~ m|[0-9]|) {
			$first .= qq[$char,];
			
		# a letter, append it and a comma to $second 
		} elsif ($char =~ m|[a-z]|i) {
			$second .= qq['$char',];
		
		# a comma, append '], [' to both $first and $second
		} elsif ($char eq ',') {
			$first .= '], [';
			$second .= '], [';
		}
	}
	
	# tweaks to eliminate empty [] pairs and convert ,] to ]
	$output = qq([$first]] and [$second]]);
	$output =~ s|,]|]|g;
	$output =~ s|\[],\s*||g;
	say qq[Output: $output];		
}
