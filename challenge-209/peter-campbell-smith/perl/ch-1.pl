#!/usr/bin/perl

# Peter Campbell Smith - 2023-03-20

use v5.28;
use utf8;
use warnings;

# You are given an array of binary bits that ends with 0. Valid sequences in the bit string are:
# [0] -decodes-to-> "a"
# [1, 0] -> "b"
# [1, 1] -> "c"
# Write a script to print 1 if the last character is an “a” otherwise print 0.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/209/1

test_for_a([1, 0, 0]);
test_for_a([1, 1, 1, 0]);
test_for_a([1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0]);
test_for_a([1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0]);
test_for_a([0]);

sub test_for_a {
	
	my (@bits, $bit_string, $good);
	
	# get array and convert to string
	@bits = @{$_[0]};
	$bit_string = join('', @bits);
	
	# if it ends 00 or is just 0 then it ends in 'a'
	if ($bit_string =~ m|00$| or $bit_string eq '0') {
		$good = 1;
		
	# if it ends 10 then it ends in 'a'	if the final 0 is preceded by an even no of 1s
	} else {
		$bit_string =~ m|(1*)0$|;
		$good = length($1) & 1 ? 0 : 1;
	}
	
	# say the answer
	say qq[\nInput:  \@bits = (] . join(', ', @bits) . qq[)\nOutput: $good];
}
