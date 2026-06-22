#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-22
use utf8;     # Week 379 - task 2 - Armstrong number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Math::Int2Base ('int2base', 'base2int');

armstrong_number(10, 10000);
armstrong_number(7, 1000);
armstrong_number(16, 1000);
armstrong_number(9, 1000);

sub armstrong_number {
	
	my ($base, $limit, $j, $jb, $power, $sum, $output);
	
	# initialise
	($base, $limit) = @_;
	
	# loop over possibles
	for $j (0 .. $limit) {
		
		# get digits of $j in base $base and count them
		$jb = int2base($j, $base);
		$power = length($jb);
		
		# now sum digits ** $power
		$sum = 0;
		$sum += base2int(substr($jb, $_, 1), $base) ** $power 
			for 0 .. $power - 1;
		
		# found one!
		$output .= qq[$j, ] if $sum == $j;
	}
	
	say qq[\nInput:  \$base = $base, \$limit = $limit];
	say qq[Output: ] . substr($output, 0, -2);
}
