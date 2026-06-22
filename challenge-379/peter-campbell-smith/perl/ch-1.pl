#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-22
use utf8;     # Week 379 - task 1 - Reverse string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_string('abcde');
reverse_string('The quick brown fox jumps over the lazy dog');
reverse_string('Linke Grüne wollen mehr Geld für ärmere Rentner');
reverse_string('');

sub reverse_string {
	
	# initialise
	my ($string, $gnirts, $last);
	$string = $_[0];
	$last = length($string) - 1;
	$gnirts = '';
	
	# reverse string
	substr($gnirts, $_, 1) = substr($string, $last - $_, 1) for 0 .. $last;
	
	# report
	say qq[\nInput:  '$string'];
	say qq[Output: '$gnirts'];	
}
