#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-17
use utf8;     # Week 226 task 1 - Shuffle string
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

shuffle_string('lacelengh', [3, 2, 0, 5, 4, 8, 6, 7, 1]);
shuffle_string('rulepark', [4, 7, 3, 1, 0, 5, 2, 6]);
shuffle_string('aaacccdeefgiiiiiiillloopprrssstuux',
	[6, 11, 24, 5, 19, 29, 27, 3, 20, 9, 12, 8, 13, 15, 18, 23, 26, 30, 
	7, 14, 25, 28, 31, 2, 22, 4, 10, 0, 16, 33, 17, 1, 32, 21]);
	
sub shuffle_string {
	
	my ($string, @indices, $result);
	
	# initialise
	$string = $_[0];
	@indices = @{$_[1]};
	
	# prepopulate $result with '_'
	$result = '_' x length($string);
	
	# copy chars: string[j] -> result[indices[j]]
	substr($result, $indices[$_], 1) = substr($string, $_, 1) for 0 .. @indices - 1;

	say qq[\nInput:  \$string = '$string',\n        \@indices = (] . join(qq[, ], @indices) . qq[)];
	say qq[Output: '$result'];
}
