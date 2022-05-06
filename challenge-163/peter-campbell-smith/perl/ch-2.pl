#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-03
# PWC 163 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# You are given a list of positive numbers, @n.
# Write a script to find out the summations as described below.
# The nth row starts with the second element of the (n-1)th row.
# The following element is sum of all elements except first element of previous row.
# You stop once you have just one element in the row.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/lot-of-ands-and-strange-grid.html

my (@tests, $test, @n, $rows, $row, $col, @grid, $width);

@tests = ([1, 2, 3, 4, 5], [1, 3, 5, 7, 9], [12, 32, 43, 72, 34, 99, 6, 50]);

# loop over tests
for $test (@tests) {
	@n = @$test;
	$rows = scalar @n;
	
	# create a grid of the output
	for $row (0 .. $rows - 1) {
		for $col (0 .. $rows - 1) {
			
			# the first row is just the input
			if ($row == 0) {
				$grid[0][$col] = $n[$col];
			
			# any cell where $col < $row is blank - so make it 0 for now
			} elsif ($col < $row) {
				$grid[$row][$col] = 0;
				
			# all the other cells are the sum of the cell to the left and the cell above
			} else {
				$grid[$row][$col] = $grid[$row - 1][$col] + $grid[$row][$col - 1];
			}
		}
	}
	
	# for a nice output the width of each column is the width of the final cell + 1
	$width = length($grid[$rows - 1][$rows - 1]) + 1;
	
	# output the result - padded to $width, or if zero, just $width spaces
	say '';
	for $row (0 .. $rows - 1) {
		for $col (0 .. $rows - 1) {
			print $grid[$row][$col] ? sprintf("\%${width}d", $grid[$row][$col]) : (' ' x $width);
		}
		say '';
	}	
}
