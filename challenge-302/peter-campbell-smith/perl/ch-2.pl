#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-30
use utf8;     # Week 302 - task 2 - Step by step
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

step_by_step(-3, 2, -3, 4, 2);
step_by_step(1, -2, -3);
step_by_step(6, 7, 8, 9, 10);

# larger example
my @ints;
push @ints, int(rand(50)) - 25 for 0 .. 99;
step_by_step(@ints);

sub step_by_step {
	
	my (@ints, $i, $sum, $least);
	@ints = @_;
	
	# find the smallest sum ($least) if we start with 0
	$least = 1e6;
	for $i (@ints) {
		$sum += $i;
		$least = $sum if $sum < $least;
	}
	
	# the answer is (1 - $least)
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[)];
	say qq[Output: ] . ((1 - $least) > 0 ? (1 - $least) : 1);
}
