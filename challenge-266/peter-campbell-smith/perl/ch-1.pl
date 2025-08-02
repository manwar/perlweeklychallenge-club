#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-22
use utf8;     # Week 266 - task 1 - Uncommon words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

uncommon_words('Mango is sweet', 'Mango is sour');
uncommon_words('Roses are red', 'Violets are blue');
uncommon_words('Red red roses are sweet', 'Roses are sweet');
uncommon_words('London is the capital of the UK', 'The capital of the UK is London');
uncommon_words('Alpha Bravo Charlie Delta Echo', 'Foxtrot Golf Hotel India Juliett');

sub uncommon_words {
	
	my (@words, %counts, $uncommon);
	
	# concatenate the lines, lower-cased, and count word frequency
	@words = split(/ +/, lc(qq[$_[0] $_[1]]));
	$counts{$_} ++ for @words;
	
	# find the words where frequency is 1
	$uncommon .= $counts{$_} == 1 ? qq['$_', ] : '' for sort keys %counts;
	
	# show the answer
	say qq[\nInput:  \$line1 = '$_[0]'\n        \$line2 = '$_[1]'];
	say qq[Output: (] . ($uncommon ? substr($uncommon, 0, -2) : q['']) . ')';
}	
