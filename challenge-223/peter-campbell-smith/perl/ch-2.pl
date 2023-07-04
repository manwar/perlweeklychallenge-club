#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-26
use utf8;     # Week 222 task 1 - Box coins
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($max_cash, $best_explain);

box_coins(3, 1, 5, 8);
box_coins(1, 5);
box_coins(3, 8, 6, 9, 2, 4, 5, 9, 2);

sub box_coins {
	
	my (@boxes, $step);
	
	# initialise
	@boxes = @_;
	$step = 1;
	$max_cash = 0;
	$best_explain = '';
	
	# start first step
	make_step($step, \@boxes, 0, '');
	
	# display result
	say qq[\nInput:  \@box = (] . join(', ', @boxes) . q[)];
	say qq[Output: $max_cash\n$best_explain];
}

sub make_step {
	
	my ($step, $boxes, $cash, $explain, $last, $j, $coin1, $coin2, $coin3,
		$new_cash, $new_explain, $b, @new_boxes);

	# initialise
	($step, $boxes, $cash, $explain) = @_;
	$last = scalar @$boxes - 1;

	# loop over picked box
	for ($j = 0; $j <= $last; $j ++) {
		
		# get 3 sets of coins and calculate gain
		$coin1 = $j != 0 ? $boxes->[$j - 1] : 1;
		$coin2 = $boxes->[$j];
		$coin3 = $j != $last ? $boxes->[$j + 1] : 1;
		$new_cash = $coin1 * $coin2 * $coin3;
		
		# explain results
		$new_explain = qq[Step $step: pick box [i=$j] and ];
		$new_explain .= qq[collect coins $coin1 * $coin2 * $coin3 => $new_cash.\n];
		
		# take another step
		if ($last > 0) {
			@new_boxes = ();
			for ($b = 0; $b <= $last; $b ++) { 
				push @new_boxes, $boxes->[$b] if $b != $j;
			}
			$new_explain .= qq[   Boxes remaining (] . join(', ', @new_boxes) . qq[).\n];
			make_step($step + 1, \@new_boxes, $cash + $new_cash, $explain . $new_explain);

		# reached bottom of recursion
		} else {
			$cash += $new_cash;
			if ($cash > $max_cash) {
				$max_cash = $cash;
				$best_explain = $explain . $new_explain . qq[   No boxes remaining.];
			}
		}
	}
	return;
}
