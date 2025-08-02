#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-17
use utf8;     # Week 309 - task 2 - Min diff
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

min_diff(1, 5, 8, 9);
min_diff(9, 4, 1, 7);

my @ints;
push @ints, int(rand(1000)) for 0 .. 11;
min_diff(@ints);

sub min_diff {
	
	my (@ints, $min_gap, $gap, $j, $where);
	
	# initialise
	@ints = sort {$a <=> $b} @_;	
	$min_gap = 1e9;
	
	# loop over @ints starting at the second element
	for $j (1 .. $#ints) {
		$gap = $ints[$j] - $ints[$j - 1];
		next if $gap >= $min_gap;
		
		# found the smallest so far
		$min_gap = $gap;
		$where = qq[$ints[$j - 1] and $ints[$j]];
	}
	
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output: minimum difference is $min_gap between $where];
}
