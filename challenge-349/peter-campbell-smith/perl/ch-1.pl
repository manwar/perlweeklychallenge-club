#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-24
use utf8;     # Week 349 - task 1 - Power string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

power_string('textbook');
power_string('zzzzz');
power_string('abcde');
power_string('xoooxooooxoooooxoooo');

sub power_string {
	
	my ($string, $chars);
	
	# initialise
	$string = shift;	
	$chars = length($string);
	
	# decrement chars while consecutive characters
	while ($chars-- > 1) {
		last if $string =~ m|(.)\1{$chars}|;
	}
	
	say qq[\nInput:  '$string'];
	say qq[Output: ] . ($chars + 1);
}
