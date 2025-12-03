#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-01
use utf8;     # Week 350 - task 1 - Good substrings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

good_substrings('abcaefg');
good_substrings('xyzzabc');
good_substrings('aababc');
good_substrings('qwerty');
good_substrings('zzzaaa');

sub good_substrings {
	
	my (@chars, $p, $good, $explain);
	
	# initialise
	@chars = split('', $_[0]);
	
	# loop over chars
	$p = 0;
	while ($p < @chars - 2) {
		
		# skip forward 2 if these two match
		if ($chars[$p + 1] eq $chars[$p + 2]) {
			$p ++;

		# result!
		} elsif ($chars[$p] ne $chars[$p + 1] and $chars[$p] ne $chars[$p + 2]) { 
			$good ++;
			$explain .= qq['$chars[$p]$chars[$p + 1]$chars[$p + 2]', ];
		}
		$p ++;
	}
	
	say qq[\nInput:  '$_[0]'];
	say qq[Output: ] . ($good ? qq[$good - ] . substr($explain, 0, -2) : 0);
}
