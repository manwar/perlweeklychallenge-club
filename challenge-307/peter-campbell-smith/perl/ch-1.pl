#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-03
use utf8;     # Week 307 - task 1 - Check order
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

check_order(5, 2, 4, 3, 1);
check_order(1, 2, 1, 1, 3);

my @ints;
push @ints, int(rand(10)) for 0 .. 49;
check_order(@ints);

sub check_order {
	
	my (@ints, @sorted, @different, $j);
	
	# sort the list
	@ints = @_;
	@sorted = sort {$a <=> $b} @ints;
	
	# find indices where original and sorted differ
	for $j (0 .. $#ints) {
		push @different, $j if $ints[$j] != $sorted[$j];
	}		
	
	say qq[\nInput:  \@ints =      (] . join(', ', @ints) . ')';
	say qq[        \@sorted =    (] . join(', ', @sorted) . ')';
	say qq[Output: \@different = (] . join(', ', @different) . ')';
}
