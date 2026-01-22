#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-19
use utf8;     # Week 357 - task 1 - Kaprekar constant
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

# Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar&rsquo;s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.


kaprekar_constant(3524);
kaprekar_constant(6174);
kaprekar_constant(9998);
kaprekar_constant(1001);
kaprekar_constant(9000);
kaprekar_constant(1111);

sub kaprekar_constant {
	
	my ($k, $asc, $desc, $n, $explain);
	
	# initialise
	$k = $_[0];
	$explain = qq[$k → ];
	$n = 0;
	
	# repeatedly reverse and subtract
	while ($k != 6174 and $k != 0) {

		# ensure 4 digits
		$asc = substr("000$k", -4, 4);
		
		# sort digits
		$asc = sprintf('%04d', join('', sort(split('', $k))));
		
		# reverse digits and subtract
		$desc = reverse($asc);
		$k = abs($asc - $desc);
		
		# record
		$n ++;
		$explain .= sprintf('%04d', $k) . ' → ';
	}
	
	say qq[\nInput:  $_[0];];
	say qq[Output: ] . ($k ? (qq[$n ∵ ] . substr($explain, 0, -3)) : -1);
}
