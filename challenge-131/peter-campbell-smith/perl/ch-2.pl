#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# PWC 131 task 1 - Peter Campbell Smith - 2021-09-20

# You are given a sorted list of unique positive integers.
# Write a script to return list of arrays where the arrays are consecutive integers.

my $input;

# loop over input examples
until (eof(DATA)) {
	$input = <DATA>;
	chop $input;
	do_task();
}

sub do_task {
	
	my ($prev, $output);
	
	# loop over list
	$prev = -1;
	while ($input =~ m|(\d+)|g) {          # consecutive  # non-consecutive
		$output .= ($1 == ($prev + 1)) ?   ", $1" :       "], [$1";
		$prev = $1;
	}
	$output =~ s|...|(|;   # tidy the start of $output
	say "\nInput:  ($input)\nOutput: $output])";
}

__DATA__
1, 2, 3, 6, 7, 8, 9
11, 12, 14, 17, 18, 19
2, 4, 6, 8
1, 2, 3, 4, 5
