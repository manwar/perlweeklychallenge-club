#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-29
use utf8;     # Week 380 - task 2 - Reverse degree
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_degree('bbc');
reverse_degree('racecar');
reverse_degree('zyx');
reverse_degree('supercalifragilisticexpialidocious');

sub reverse_degree {
	
	my ($string, $j, $reverse_degree);
	
	# initialise
	$string = shift;
	say qq[\nInput:  '$string'];
	$string =~ s|[^a-z]||g;
	$string = lc($string);
	
	# calculate reverse degree
	for $j (0 .. length($string) - 1) {
		$reverse_degree +=
			($j + 1) * (123 - ord(substr($string, $j, 1)));
	}

	say qq[Output: $reverse_degree];
}

