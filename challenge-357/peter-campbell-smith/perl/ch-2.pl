#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-19
use utf8;     # Week 357 - task 2 - Unique fraction generator
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

unique_fraction_generator(3);
unique_fraction_generator(4);
unique_fraction_generator(1);
unique_fraction_generator(6);
unique_fraction_generator(5);
unique_fraction_generator(10);

sub unique_fraction_generator {
	
	my ($n, $i, $j, $q, %quotient, $result);
	
	# initialise
	$n = $_[0];
	
	# generate fractions
	for $i (1 .. $n) {
		for $j (1 .. $n) {
			$q = $i / $j;
			
			# save result unless an equal earlier one
			$quotient{$q} .= qq[$i/$j] unless $quotient{$q};
		}
	}
	
	# sort them by value
	$result = '';
	for $q (sort {$a <=> $b} keys %quotient) {
		$result .= qq[$quotient{$q}, ];
	}
	
	say qq[\nInput:  $n];
	say qq[Output: ] . substr($result, 0, -2);
}
