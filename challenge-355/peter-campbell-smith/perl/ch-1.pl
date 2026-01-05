#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-05
use utf8;     # Week 355 - task 1 - Thousand separator
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

thousand_separator(1);
thousand_separator(12);
thousand_separator(123);
thousand_separator(1234);
thousand_separator(123456);
thousand_separator(12345678901234567890);

sub thousand_separator {
	
	my ($number, $n, $reversed);
	
	# reverse the input
	$reversed = reverse($_[0]);	
	
	# repeatedly change 5555 to 555,5
	do { $n = $reversed =~ s|(\d{3})(\d)|$1,$2| } until $n == 0;
		
	say qq[\nInput:  $_[0]];
	say qq[Output: ] . reverse($reversed);
}
