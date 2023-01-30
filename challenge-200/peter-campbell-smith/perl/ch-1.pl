#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-16
# PWC 200 task 1

use v5.28;
use utf8;
use warnings;

# Task: Write a script to find out all Arithmetic Slices for the given array of integers. An integer array is 
# called arithmetic if it has at least 3 elements and the differences between any three consecutive elements 
# are the same.

# Blog: 

my (@tests, $test, @array, $rubric, $j, @diff, $last_diff, $run_starts);

@tests = ([1, 2, 3, 4], [1, 2, 3, 4, 6], [0, 1, 5, 9, 13, 22, 99, 101, 102, 103, 105],
	[0, 0, 0], [-3, 1, 5, 9], [10, 8, 6, 4], [7, 8, 8, 10, 13, 17], [1, 2, 3, 6, 9],
	[0, 4, 8, 12, 16, 20, 24, 28, 32]);

# loop over tests
for $test (@tests) {
	@array = @$test;
	
	# initialise
	$rubric = '';
	@diff = ();
	
	# create @diff array and put a dummy value on the end
	for $j (0 .. scalar(@array) - 2) {
		$diff[$j] = $array[$j + 1] - $array[$j];
	}
	push @diff, 1e9;
	
	# loop over the @diff array looking for runs of the same number
	$last_diff = 1e9;
	$run_starts = -1;
	for $j (0 .. scalar(@array) - 1) {
		
		# continuation of a run
		next if $diff[$j] == $last_diff;
			
		# end of a run, possible start of next one
		analyse($run_starts, $j) if $run_starts >= 0;
		$run_starts = $j;
		$last_diff = $diff[$j];
	}
	
	# report result
	say qq[\nInput:  (] . join(', ', @array) . ')';
	say qq[Output: ] . ($rubric ? substr($rubric, 0, -2) : '() as no slice found');
}	

sub analyse {
	
	# split a run into sub-runs (eg 1,2,3,4 => 1,2,3; 2,3,4; 1,2,3,4)
	my ($start, $end) = @_;
	my ($length, $sub_length, $offset, $j);
	
	# minimum run length is 3
	$length = $end - $start + 1;
	return if $length < 3;
	
	# loop over possible sub-run lengths
	for $sub_length (3 .. $length) {
		
		# loop over possible starting positions
		for $offset (0 .. $length - $sub_length) {
			
			# add sub-run to rubric
			$rubric .= '(';
			for $j ($start + $offset .. $start + $offset + $sub_length - 1) {
				$rubric .= qq[$array[$j], ];
			}
			$rubric =~ s|, $|), |;
		}
	}
}
