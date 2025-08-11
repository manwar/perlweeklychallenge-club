#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-11
use utf8;     # Week 334 - task 1 - Range sum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

range_sum([-2, 0, 3, -5, 2, -1], 0, 2);
range_sum([1, -2, 3, -4, 5], 1, 3);
range_sum([1, 0, 2, -1, 3], 3, 4);
range_sum([-5, 4, -3, 2, -1, 0], 0, 3);
range_sum([-1, 0, 2, -3, -2, 1], 0, 2);

sub range_sum {
	
	my (@integers, $from, $to, $sum);
	
	# do it
	@integers = @{$_[0]};
	$sum += $_ for @integers[$_[1] .. $_[2]];
	
	say qq[\nInput:  \@integers = (] . join(', ', @integers) . qq[), \$x = $_[1], \$y = $_[2]]; 
	say qq[Output: $sum];
}

