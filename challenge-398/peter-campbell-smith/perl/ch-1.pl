#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/398/1

use v5.26;    # The Weekly Challenge - 2026-11-02
use utf8;     # Week 398 - task 1 - Divisible average
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

divisible_average(18, 5, 7, 11);
divisible_average(6, 12, 18, 24, 30, 40);
divisible_average(3, 9, 15, 21, 27);
divisible_average(6, 12, 14, 20);
divisible_average(6, 6, 6, 10, 12);

sub divisible_average {
	
	my (@array, @sixes, $sum, $result);
	
    # initialise	
    @array = @_;
	
	# extract multiples of 6
	@sixes = grep {$_ / 6 == int($_ / 6)} @array;

    # sum and rounded average
	if (@sixes) {
        $sum += $_ for @sixes;
	    $result = int($sum / @sixes + 0.5);
	}
	
	# report
	say qq[\nInput:  (] . join(', ', @array) . ')';
	say qq[Output: ] . ($result or 0);
}
