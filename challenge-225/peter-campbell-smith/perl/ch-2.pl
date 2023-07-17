#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-10
use utf8;     # Week 225 task 2 - Left right sum diff
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

left_right_sum_diff(10, 4, 8, 3);
left_right_sum_diff(1);
left_right_sum_diff(1, 2, 3, 4, 5);
left_right_sum_diff(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5);

sub left_right_sum_diff {
	
	my (@ints, @stni, @lrsd, $count, $x);
	
	# initialise
	@ints = @_;
	$count = @ints - 1;
	
	# do the sums on @ints and the reverse of @ints
	@stni = reverse @ints;
	for $x (\@ints, \@stni) {
		unshift @$x, 0;
		pop @$x;
		$x->[$_] += $x->[$_ - 1] for 1 .. $count;
	}
	@stni = reverse @stni;
	
	# do the differences
	$lrsd[$_] = abs($ints[$_] - $stni[$_]) for 0 .. $count;
	
	# and spout
	say qq[\nInput:  \@ints  = (] . join(', ', @_) . q[)] .
	    qq[\nOutput: \@left  = (] . join(', ', @ints) . q[)] .
		qq[\n        \@right = (] . join(', ', @stni) . q[)] .
		qq[\n        \@lrsd  = (] . join(', ', @lrsd) . q[)];
	
}
