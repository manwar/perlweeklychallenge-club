#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-22
use utf8;     # Week 279 - task 2 - Split string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

split_string('good morning');
split_string('perl');
split_string('Write a script to split the given string into two');
split_string('Write a script to split the given string into three');
split_string('bcdfgh');
split_string('');

sub split_string {
	
	my ($string, $vowels);
	
	$string = shift;
	
	# count the vowels
	$vowels = () = $string =~ m|[aeiou]|gi;
	
	printf(qq[\nInput:  \$str = '%s'\n], $string);
	printf(qq[Output: %s\n], ($vowels & 1) ? 'false' : 'true');
}
