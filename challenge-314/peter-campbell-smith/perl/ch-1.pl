#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-24
use utf8;     # Week 314 - task 1 - Equal strings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

equal_strings('abc', 'abb', 'ab');
equal_strings('ayz', 'cyz', 'xyz');
equal_strings('yza', 'yzb', 'yzc');

equal_strings('', 'ijk', 'ijk');
equal_strings('mno', '', '');
equal_strings('abc', 'abc', 'abc');
equal_strings('ab', 'abc', 'abc');
equal_strings('abcd', 'abc', 'abc');

sub equal_strings {
	
	my (@strings, $all, $keep, $n, $test);
	
	# initialise
	@strings = @_;
	say qq[\nInput:  \@strings = ('] . join(qq[', '], @strings) . qq[')];
	
	# get total characters in all strings
	$all += length($_) for @strings;
	
	# check match of first 1, 2 ... chars
	for $n (1 .. 99) {
		$test = substr($strings[0], 0, $n);
		
		# if they all match keep going
		if (substr($strings[1], 0, $n) eq $test and substr($strings[2], 0, $n) eq $test) {
			$keep += 3;
		
		# else we're done
		} else {
			say qq[Output: ] . ($keep ? $all - $keep : -1);
			return;
		}
	}
	
	# but there is an edge case where all 3 match
	say qq[Output: 0];
	return;
}
