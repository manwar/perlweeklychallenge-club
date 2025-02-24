#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-17
use utf8;     # Week 309 - task 1 - Min gap
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

min_gap(2, 8, 10, 11, 15);
min_gap(1, 5, 6, 7, 14);
min_gap(8, 20, 25, 28);

my @ints;
push @ints, int(rand(1000)) for 0 .. 11;
@ints = sort {$a <=> $b} @ints;
min_gap(@ints);

sub min_gap {
	
	my (@ints, $min_gap, $gap, $j, $before);
	
	# initialise
	@ints = @_;	
	$min_gap = 1e9;
	
	# loop over @ints starting at the second element
	for $j (1 .. $#ints) {
		$gap = $ints[$j] - $ints[$j - 1];
		next if $gap >= $min_gap;
		
		# found the smallest so far
		$min_gap = $gap;
		$before = $ints[$j];
	}
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: minimum gap ($min_gap) is before $before];
}
