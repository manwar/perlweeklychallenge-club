#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-29
use utf8;     # Week 280 - task 1 - Twice appearance
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

twice_appearance('acbddbca');
twice_appearance('abccd');
twice_appearance('abcdabbb');
twice_appearance('aabcdef');
twice_appearance('abcdeff');
twice_appearance('soporific');

sub twice_appearance {
	
	my ($str, $j, $a);
	$str = shift;
	
	# iterate along string
	for $j (0 .. length($str) - 1) {
		$a = substr($str, $j, 1);
		
		# check if this letter appears twice
		last if $str =~ m|$a.*$a|;
		$a = '';
	}
	printf(qq[\nInput:  \@str = '%s'\n], $str);
	printf(qq[Output: '%s'\n], $a);
}
