#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-14
use utf8;     # Week 391 - task 1 - Array median
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

array_median([2], [4]);
array_median([1, 2, 3], [7, 8, 9, 10]);
array_median([], [10, 20, 30, 40]);
array_median([100], [1, 2, 3, 4, 5, 6, 7]);
array_median([1, 2, 2], [2, 2, 3]);

sub array_median {
	
	my (@merged, $middle, $median);
	
	# merge, sort and count arrays
	push @merged, @{$_[$_]} for 0 .. 1;
	@merged = sort {$a <=> $b} @merged;
	$middle = @merged / 2 - 1;
	
	# even number of entries
	if ($middle == int($middle)) {
		$median = ($merged[$middle] + $merged[$middle + 1]) / 2;
		
	# odd number of entries
	} else {
		$median = ($merged[$middle + 1]);
	}
	
	# report
	say qq[\nInput:  \@arr1 = (] . join(', ', @{$_[0]}) .
		'), @arr2 = (' . join(', ', @{$_[1]}) . ')';
	say qq[Output: $median];
}
