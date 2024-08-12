#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-05
use utf8;     # Week 281 - task 1 - Check color
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

check_color('d3');
check_color('g5');
check_color('a1');
check_color('h8');

sub check_color {
	
	my ($col, $row) = $_[0] =~ m|(.)(.)|;
	
	# convert column letter to number (0-7), multiply by
	# row number and odd results are light, even ones dark	

	printf(qq[\nInput:  \$square = '%s'\n], $col . $row);
	printf(qq[Output: %s\n], ((ord($col) - ord('a')) * $row) & 1 ? 'true' : 'false');
}
