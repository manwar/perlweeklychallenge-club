#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-04
use utf8;     # Week 233 task 2 - Frequency sort
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

frequency_sort(1, 1, 2, 2, 2, 3);
frequency_sort(2, 3, 1, 3, 2);
frequency_sort(-1, 1, -6, 4, 5, -6, 1, 4, 1);
frequency_sort(0, 0, 0, 0, -10, -5, -5 );

# bigger list
my @ints;
for (0 .. 50) {
	push @ints, int(rand(30)) - 15;
}
frequency_sort(@ints);

sub frequency_sort {
	
	my (@ints, @sorted, @freq, $j, %items, $f, $v, @output, $min, $max);
	
	@ints = @_;
	@sorted = sort { $a <=> $b } @ints;
	$min = $sorted[0];   # can be -ve
	$max = $sorted[-1] - $min;
	
	# get frequency of each distinct number: $freq[$j] is the frequency of ($j - $min)
	$freq[$_ - $min] ++ for @ints;
	
	# create $items{'aaaaaa|bbbbbb'} where aaaaaa is the frequency of $j and bbbbbb is $max - $j
	for $j (0 .. scalar @freq - 1) {
		next unless $freq[$j];
		$items{sprintf('%06d_%06d', $freq[$j], $max - $j)} = 1;
	}
	
	# sort by key to create output array
	for $j (sort keys %items) {
		$j =~ m|(\d+)_(\d+)|;
		($f, $v) = ($1 + 0, $max + $min - $2);
		push @output, $v for 1 .. $f;
	}	
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: (] . join(', ', @output) . ')';
}
