#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-17
use utf8;     # Week 313 - task 2 - Reverse letters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

reverse_letters('p-er?l');
reverse_letters('wee-k!L-y');
reverse_letters('_c-!h_all-en!g_e');
reverse_letters('neerg:si:ssarg');

sub reverse_letters {
	
	my ($string, $letters, $reversed, $char, $i);
	
	# extract letters and reverse them
	$string = shift;
	$letters = $string;
	$letters =~ s|[^a-z]||gi;
	$letters = reverse($letters);
	
	# substitute a reversed letter for every letter in string
	for $char (split('', $string)) {
		$reversed .= $char =~ m|[a-z]|i ? substr($letters, $i ++, 1) : $char;
	}
	
	# report
	say qq[\nInput:  \$string   = '$string'];
	say qq[Output: \$reversed = '$reversed'];
}
