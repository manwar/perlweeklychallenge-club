#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-17
use utf8;     # Week 226 task 2 - Zero array
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @ints);

zero_array(1, 5, 0, 3, 5);
zero_array(2, 1, 4, 0, 3);

for $j (0 .. 20) {
	push @ints, int(rand(20));
}
zero_array(@ints);

sub zero_array {
	
	my (@ints, @sorted, $j, $count, $least, $explain);
	
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[)];
	$count = 0;
	$explain = '';

	while (1) {
		
		# find the least non-zero element left
		@sorted = sort { $a <=> $b } @ints;
		shift @sorted while (@sorted and $sorted[0] == 0);
		last unless @sorted;
		$least = $sorted[0];
		
		# subtract least from all non-zeroes
		for $j (0 .. @ints - 1) {
			$ints[$j] -= $least if $ints[$j];
		}
		$count ++;
		$explain .= qq[operation $count: pick $least => (] . join(', ', @ints) . qq[)\n];
	}
	$explain =~ s|\n$||;
	say qq[Output: $count\n$explain];

}