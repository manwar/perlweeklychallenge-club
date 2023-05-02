#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-24
use utf8;     # Week 214 task 2 - Collect points
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($best_score, $best_explain);

collect_points(2, 4, 3, 3, 3, 4, 5, 4, 2);
collect_points(1, 2, 2, 2, 2, 1);
collect_points(1);
collect_points(2, 2, 2, 1, 1, 2, 2, 2);
collect_points(3, 1, 4, 1, 5, 9, 2, 6, 5, 3);

sub collect_points {
	
	my (@points, $last, $k, @elements, $j, $e);
	
	# initialise
	@points = @_;
	$best_score = 0;
	$best_explain = '';
	
	# convert list to elements: $elements[$k][0] is the number 
	# of consecutive occurrences of $elements[$k][1]
	$last = -1;
	$k = -1;
	for ($j = 0; $j < scalar @points; $j ++) {
		if ($points[$j] == $last) {
			$elements[$k][0] ++;
		} else {
			$elements[++ $k][0] = 1;
			$elements[$k][1] = $points[$j];
		}
		$last = $points[$j];
	}	

	# analyse list and show results
	analyse(0, '', @elements);
	say qq[\nInput:  \@numbers = (] . join(', ', @points) . qq[)];
	say qq[Output: $best_score (] . substr($best_explain, 0, -2) . qq[)];
}

sub analyse {
	
	# successively removes 1 element and recurses until only 1 is left
	
	my (@elements_in, $score_in, $explain_in, $last_element, $score, $explain,
		$k, $start, @elements_out, @save);
	
	# get arguments and initialise
	$score_in = $_[0];
	$explain_in = $_[1];
	@elements_in = @_[2 .. scalar @_ - 1];
	for $k (0 .. scalar @elements_in - 1) {
		$save[$k] = $elements_in[$k];
	}
	$last_element = scalar @elements_in - 1;
	$score = 0;
	
	# try eliminating each element in turn
	F: for $k (0 .. $last_element) {
		@elements_in = @save;
		$score = $score_in + $elements_in[$k][0] ** 2;
		$explain = qq[$explain_in$elements_in[$k][0]x$elements_in[$k][1], ];

		# return if this is the last element
		if ($last_element == 0) {
			if ($score > $best_score) {
				$best_score = $score;
				$best_explain = $explain;
			}
			last F;
		}
		
		# merge newly adjacent equal-value elements if appropriate
		$start = $k + 1;
		if ($k != 0 and $k != $last_element
			and $elements_in[$k - 1][1] == $elements_in[$k + 1][1]) {
			$elements_in[$k - 1][0] += $elements_in[$k + 1][0];
			$start = $k + 2;
		}
		
		# create reduced list
		@elements_out = ();
		push(@elements_out, @elements_in[0 .. $k - 1]) unless $k == 0;
		push(@elements_out, @elements_in[$start .. $last_element]) unless $start > $last_element;
		
		# recurse
		analyse($score, $explain, @elements_out);
		$elements_in[$k - 1][0] -= $elements_in[$k + 1][0] if $start == $k + 2;
	}
}
