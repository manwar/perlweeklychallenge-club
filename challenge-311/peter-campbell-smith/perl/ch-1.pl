#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-03
use utf8;     # Week 311 - task 1 - Upper lower
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

upper_lower('abcdeABCDE');
upper_lower('TheQuickBrownFoxJumpsOverTheLazyDog');

sub upper_lower {
	
	my ($sTrInG, $StRiNg);
	
	$sTrInG = shift @_;
	
	# add 32 to upper case, subtract 32 from lower
	$StRiNg .= ($_ gt 'Z' ? chr(ord($_) - 32) : 
	   chr(ord($_) + 32)) for split('', $sTrInG);
	
	say qq[\nInput:  \$string = $sTrInG];
	say qq[Output:           $StRiNg];
}
