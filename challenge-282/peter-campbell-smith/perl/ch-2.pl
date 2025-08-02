#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-12
use utf8;     # Week 282 - task 2 - Changing keys
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

changing_keys('aaabbbcCc');
changing_keys('abbbbb');
changing_keys('aaaaab');
changing_keys('abcde');
changing_keys('aAaAaAa');
changing_keys('Committee');

sub changing_keys {
	
	my ($str, $c, $count);
	
	# initialise
	$str = shift;
	say qq[\nInput:  \@str = '$str'];
	
	# count key changes
	$str = lc($str);
	$count = 0;
	for $c (0 .. length($str) - 2) {
		$count ++ if substr($str, $c, 1) ne substr($str, $c + 1, 1);
	}
	say qq[Output: $count];
}
