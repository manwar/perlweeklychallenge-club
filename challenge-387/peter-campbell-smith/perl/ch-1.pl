#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/387/1

use v5.26;    # The Weekly Challenge - 2026-08-17
use utf8;     # Week 387 - task 1 - Rearrange binary string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

rearrange_binary_string('111000');
rearrange_binary_string('00011');
rearrange_binary_string('01011');
rearrange_binary_string('010101');
rearrange_binary_string('00001');

sub rearrange_binary_string {
	
	my ($n, $string, $total, $c, $j);
	
	# initialise
	$n = $total = 0;
	$string = $_[0];
	
	$total ++ while $string =~ s|01|10|g;
		
	
	say qq[\nInput: '$string' ];
	say qq[Output: $total];
}
