#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-22
use utf8;     # Week 340 - task 1 - Duplicate removals
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

duplicate_removals('abbaca');
duplicate_removals('aaaaaaaa');
duplicate_removals('abcdabcd');
duplicate_removals('abcdeedcbaf');
duplicate_removals('oodrrunggnpeellyyligoogcccazztfghhgfe');
duplicate_removals('xabcdeedcbay');

sub duplicate_removals {
	
	my ($string);
	say qq[\nInput:   '$_[0]'];
	
	# imethod 1 - concise
	$string = $_[0];
	$string =~ s|$1$1|| while $string =~ m|([a-z])\1|;
	say qq[Output1: '$string'];
	
	# method 2 - faster?
	my ($last, $output, $j, $char);
	
	$string = $_[0];
	$last = '#';
	$output = '';
	for $j (0 .. length($string) - 1) {
		$char = substr($string, $j, 1);
		
		# this char same as last - discard both
		if ($char eq $last) {
			$output = substr($output, 0, -1);
			$last = substr($output, -1);
		
		# this char differs from last - append it
		} else {
			$output .= $char;
			$last = $char;
		}
	}
	say qq[Output2: '$output'];
}
