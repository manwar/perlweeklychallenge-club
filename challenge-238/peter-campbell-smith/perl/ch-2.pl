#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-09
use utf8;     # Week 238 task 2 - Persistence sort
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

persistence_sort(15, 99, 1, 34);
persistence_sort(50, 25, 33, 22);
persistence_sort(644, 939, 265, 312, 5);
persistence_sort(81, 71, 61, 51, 41);
persistence_sort(1, 10, 25, 39, 77, 679, 6788, 68889);

sub persistence_sort {
	
	my (@ints, $j, $product, @steps, $num_ints, $todo, $s, @results, $explain);
	
	@ints = @_;
	say qq[\nInput:  (] . join(', ', @ints) . ')';
	
	# sort ints so that end results are sorted within each step count
	@ints = sort {$a <=> $b} @ints;
	$num_ints = @ints - 1;
	$explain = '';
	
	# calculate digit products
	for $j (0 .. $num_ints) {
		$product = $ints[$j];
		$steps[$j] = 0;
		$explain .= qq[   $ints[$j] =>];
		
		# loop while product is not a single digit
		while ($product > 9) {
			$product =~ s|(\d)|\* $1 |g;  # converts 123 to *1*2*3
			$explain .= substr($product, 1, -1) . ' =>';
			$product = eval(qq[1$product]);   # evaluates 1*1*2*3
			$steps[$j] ++;
		}
		$explain .= qq[ $product (steps: $steps[$j])\n];
	}
	
	# loop over number of steps
	$todo = $num_ints + 1;
	STEPS: for $s (0 .. 99) {
		
		# find step counts == $s
		for $j (0 .. $num_ints) {
			if ($steps[$j] == $s) {
				push(@results, $ints[$j]);
				
				# check whether we've got them all
				$todo --;
				last STEPS unless $todo;
			}
		}
	}
	say qq[Output: (]. join(', ', @results) . qq[)\n]  . substr($explain, 0, -1);
}

	