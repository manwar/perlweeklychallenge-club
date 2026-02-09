#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-02
use utf8;     # Week 359 - task 2 - String reduction
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

string_reduction('mississippi');
string_reduction('house');
string_reduction('abcdefggfedcba');
string_reduction('aaaaaaaaaaaaaaaaaa');
string_reduction('abcdeEDCBA');
string_reduction('αβγδεεδγβαω');

sub string_reduction {
	
	my ($string, $count);
	
	# initialise
	$string = lc($_[0]);
	$count = 1;
	
	# delete matched pairs
	$count = $string =~ s|(\w)\1||g while $count;
	
	say qq[\nInput:  '$_[0]'];
	say qq[Output: '$string'];
}
