#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-12
use utf8;     # Week 356 - task 1 - Kolakoski sequence
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

kolakoski_sequence(4);
kolakoski_sequence(10);
kolakoski_sequence(100);

sub kolakoski_sequence {
	
	my ($length, @sequence, $i, $ones, $this);
	
	# initialise
	$length = $_[0];
	@sequence = (1, 2, 2);
	$ones = 1;
	
	# add items to sequence until it reaches $length
	for ($i = 3; @sequence < $length; $i ++) {
		
		# find next digit to add (1 or 2)
		$this = $i & 1 ? 1 : 2;
		
		# add one or two of that digit
		push(@sequence, $this) for 1 .. $sequence[$i - 1];
		
		# count the ones
		$ones += $sequence[$i - 1] if $this == 1;
	}
	
	# report
	say qq[\nInput:  \$length = $length];
	say qq[Output: \$sequence = ] . join('', @sequence) . 
		qq[\n        containing $ones ones];
}
