#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-01-13
use utf8;     # Week 304 - task 2 - Maximum average
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

maximum_average([1, 12, -5, -6, 50, 3], 4);
maximum_average([5, 5, 5, 5, 0, 0, 0], 4);
maximum_average([0, 0, 0, 0, 0, 6, 6], 5);

my @ints;
push @ints, int(rand(100)) - 50 for 1 .. 100;
maximum_average(\@ints, 10);

sub maximum_average {
	
	my (@ints, $n, $max_average, $max_suum, $start, $sum, $average, $subarray);
	
	# initialise
	@ints = @{$_[0]};
	$n = $_[1];
	$max_average = 0;
	
	# loop over staring points
	for $start (0 .. $#ints - $n + 1) {
		$sum = 0;
		$sum += $_ for @ints[$start .. $start + $n - 1];
		$average = $sum / $n;
		
		# potential answer
		if ($average > $max_average) {
			$max_average = $average;
			$subarray = join(', ', @ints[$start .. $start + $n - 1]);
		}
	}
	
	# report
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[), \$n = $n];
	say qq[Output: $max_average - ($subarray)];
}
