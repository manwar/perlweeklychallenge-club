#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-23
use utf8;     # Week 240 task 2 - Build array
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

build_array(0, 2, 1, 5, 3, 4);
build_array(5, 0, 1, 2, 3, 4);
build_array(5, 6, 1, 2, 3, 4);
build_array(10, 6, 3, 8, 5, 4, 1, 9, 2, 0, 7);

sub build_array {
	
	my (@old, @new, $last, @check, $good);
	
	# need to make sure the task is possible
	@old = @_;
	$last = @old - 1;
	@check = sort {$a <=> $b} @old;
	$good = $check[0] == 0;
	$good &= $check[$_] == $check[$_ - 1] + 1 for (1 .. $last);
	
	# show results
	say qq[\nInput:  \@old = (] . join(q[, ], @old) . q[)];
	if ($good) {
		$new[$_] = $old[$old[$_]] for (0 .. $last);
		say qq[Output: \@new = (] . join(', ', @new) . ')';

	} else {
		say qq[Output: impossible];
	}
}
	