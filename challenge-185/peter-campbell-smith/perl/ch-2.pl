#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-02
# PWC 185 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given a list of random strings.
# Write a script to change the first four characters matching [a-z0-9] to x and keep the rest as it is.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/manipulating-characters.html

my (@tests, $test, @list, $item, $j, $output);

@tests = (['ab-cde-123', '123.abc.420', '3abc-0010.xy'], 
	['A5h&kP.....z', '!"£$%^&*()', 'xxxx00000', 'abcd', 'ǀØΨ£‡⁇ aaaa']);

# loop over tests
for $test (@tests) {
	@list = @$test;
	
	# initialise
	say qq[\nInput: \@list = (] . join(', ', @list) . ')';
	$output = '';
	
	# loop over items within test
	for $item (@list) {
		$item =~ s|^(.*?)[a-z0-9](.*?)[a-z0-9](.*?)[a-z0-9](.*?)[a-z0-9]|$1x$2x$3x$4x|;
		$output .= qq[$item, ];
	}
	
	# and print the answer
	say qq[Output:        (] . substr($output, 0, -2) . ')';
}
