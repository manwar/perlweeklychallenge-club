#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-21
# PWC 192 task 2

use v5.28;
use utf8;
use warnings;

# You are given a list of integers greater than or equal to zero, @list. Write a script to distribute the number 
# so that each members are same. If you succeed then print the total moves otherwise print -1.
#
# From the examples, it appears that a move comprises moving 1 to an adjacent cell.

# Blog: https://pjcs-pwc.blogspot.com/2022/11/flipping-easy-and-distributing-fairly.html

my (@tests, $test, $sum, $cells, $cell, $target, $moves, $rubric);

@tests = ([1, 0, 5], [0, 2, 0], [0, 3, 0],
	[6, 6, 0, 0], [0, 6, 6, 0], [0, 0, 6, 6]);

# loop over tests
for $test (@tests) {
	
	# initialise and compute sum of all cells
	$sum = $moves = 0;
	$rubric = '';
	$sum += $_ for (@$test);
	$cells = scalar(@$test);
	say qq[\nInput:  (] . join(', ', @$test) . ')'; 
	
	# test for impossibility (sum not a multiple of the number of cells)
	if ($sum % $cells != 0) {
		say qq[Output: -1];
		next;
	}
	
	# calculate the target - the number that will end up in every cell
	$target = $sum / $cells;
	
	# start at cell 0 and step along to the last but one cell
	for $cell (0 .. $cells - 2) {
		
		# if the cell contents > $target move the surplus, 1 by 1, to the next cell
		while ($test->[$cell] < $target) {
			$test->[$cell] ++;		
			$test->[$cell + 1] --;
			show_move(@$test);
		}
					
		# if the cell contents < $target move the deficit, 1 by 1, from the next cell
		while ($test->[$cell] > $target) {
			$test->[$cell] --;
			$test->[$cell + 1] ++;
			show_move(@$test);
		}
	}
	
	print qq[Output: $moves\n\n$rubric];
} 

sub show_move {
	
	# add one move to rubric for later output
	$moves ++;
	$rubric .= qq[    Move \#$moves: ] . join(', ', @_) . qq[\n];
}
