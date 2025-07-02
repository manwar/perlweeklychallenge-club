#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-30
use utf8;     # Week 328 - task 1 - Replace all ?
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

replace_all_queries('abc?def?ghi');
replace_all_queries('?a?a?a?a?a?a?a?');
replace_all_queries('a?????b');
replace_all_queries('?????');
replace_all_queries('?br?c?d?br?');
replace_all_queries('a??????b');
replace_all_queries('a?b?a?b?c?a');

sub replace_all_queries {
	
	my ($string, $z);
	
	# initialise - add '*' to start and end
	$string = qq[*$_[0]*];
	
	# loop while string contains a '?'
	while ($string =~ m|^(.*?)(.)\?(.?)(.*)|) {
		
		# replace ? with a, b or c
		for $z ('a', 'b', 'c') {
			if ($z ne $2 and $z ne $3) {
				$string = qq[$1$2$z$3$4];
				last;
			}
		}
	}	
	
	say qq[\nInput:  $_[0]];
	say qq[Output: ] . substr($string, 1, -1);
}
