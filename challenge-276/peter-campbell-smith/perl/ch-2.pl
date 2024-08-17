#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-01
use utf8;     # Week 276 - task 2 - Maximum frequency
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my @ints;

maximum_frequency(1, 2, 2, 4, 1, 5);
maximum_frequency(1, 2, 3, 4, 5);
maximum_frequency(1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2);

push @ints, int(rand(15)) for 0 .. 99;
maximum_frequency(@ints);

sub maximum_frequency {
	
	my (@ints, $max_freq, $int, %freq, $count, $explain, $s, $they);
	
	@ints = @_;
	$max_freq = 0;
	for $int (@ints) {
		$freq{$int} ++;
		$max_freq = $freq{$int} if $freq{$int} > $max_freq;
	}
	for $int (sort keys %freq) {
		next unless $freq{$int} == $max_freq;
		$count += $freq{$int};
		$explain .= qq[$int, ];
	}

	printf(qq[\nInput:  \@ints = (%s)\n], join(', ', @ints));
	printf(qq[Output: %d integers occur with frequency %d: %s\n], $count, $max_freq, substr($explain, 0, -2));
}
