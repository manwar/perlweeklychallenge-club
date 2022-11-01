#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-31
# PWC 189 task 2

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given an array of 2 or more non-negative integers. Write a script to find out the smallest slice, 
# ie contiguous subarray of the original array, having the degree of the given array.
# The degree of an array is the maximum frequency of an element in the array.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/the-smallest-greater-and-shortest-slice.html 

my (@tests, $test, @array, $degree, $size, $start, $slice_degree, @slice, $found);

@tests = ([1, 3, 3, 2], [1, 2, 1, 3], [1, 3, 2, 1, 2], [1, 1, 2, 3, 2], [2, 1, 2, 1, 1],
	[1, 5, 8, 6, 3, 4, 2, 6, 5, 7, 3, 4, 5, 1 ,3, 4, 2, 3, 5, 1, 2, 7, 4, 6, 2, 4, 1, 8, 4, 3],
	[1, 1, 1, 2, 2, 2]);

TEST: for $test (@tests) {
	@array = @$test;
	
	# get degree of supplied array
	$degree = get_degree(@array);	
	say qq[\nInput:  \@array = (]. join(', ', @array), qq[), degree $degree];
	
	# now test possible slices from shortest to longest
	$found = 0;
	SIZE: for $size ($degree .. scalar @array) {
		
		# ... and starting from the beginning up to the last position where rgere are still $size left
		for $start (0 .. scalar @array - $size) {
			@slice = @array[$start..$start + $size - 1];
			$slice_degree = get_degree(@slice);
			
			# do we have an answer?
			if ($slice_degree == $degree) {
				say qq[Output: (] . join(', ', @slice) . qq[), degree $slice_degree];
				$found = 1;
			}
		}
		
		# we have found answer(s) at this $size, so don't look at longer possibilities
		last SIZE if $found;
	}
}

sub get_degree {
	
	my ($degree, $j, %freq);
	
	# find the frequency of the most frequent element(s)
	$degree = 0;
	for $j (@_) {
		$freq{$j} ++;
		$degree = $freq{$j} if $freq{$j} > $degree;
	}
	return $degree;
}
