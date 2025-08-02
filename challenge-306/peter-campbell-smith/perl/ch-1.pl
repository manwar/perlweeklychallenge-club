#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-27
use utf8;     # Week 306 - task 1 - Odd sum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

odd_sum(2, 5, 3, 6, 4);
odd_sum(99);
odd_sum(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20);

sub odd_sum {
	
    my (@ints, $sum, $start, $end);
    
    # initialise
    @ints = @_;
	$sum = 0;
    
    # loop over start and end points
    for $start (0 .. $#ints) {
		for ($end = $start; $end <= $#ints; $end += 2) {
			$sum += $ints[$_] for $start .. $end;
		}
    }
    
    # report
    say qq[\nInput:  \@ints = (] . join(', ', @ints) . qq[)];
    say qq[Output: $sum];
}
