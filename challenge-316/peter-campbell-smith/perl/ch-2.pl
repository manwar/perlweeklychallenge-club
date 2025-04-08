#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-07
use utf8;     # Week 316 - task 2 - Subsequence
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

subsequence('uvw', 'bcudvew');
subsequence('bcudvew', 'uvw');
subsequence('character', 'cat');
subsequence('scared', 'reduce');
subsequence('same', 'same');
subsequence('', 'challenge');

sub subsequence {
	
	my ($string1, $string2, $pattern1, $pattern2);
	
	# intitlaise
	($string1, $string2) = @_;	
	say qq[\nInput:  \$string1 = '$string1', \$string2 = '$string2'];
	
	# create patterns (eg abc -> a.*b.*c.*)
	$pattern1 = join('.*', split('', $string1));
	$pattern2 = join('.*', split('', $string2));
	
	# see if they match
	if ($string1 =~ m|$pattern2|) {
		say qq[Output: yes - '$string2' is a subsequence of '$string1'];
	} elsif ($string2 =~ m|$pattern1|) {
		say qq[Output: yes - '$string1' is a subsequence of '$string2'];
	} else {
		say qq[Output: no - neither string is a subsequence of the other];
	}		
}
