#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-20
# PWC 170 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# You are given 2 matrices.
# Write a script to generate the Kronecker Product of the given 2 matrices.

# Blog: https://pjcs-pwc.blogspot.com/2022/06/primorials-and-kronecker-products.html

my ($test, $A, $B, $K, $m, $n, $p, $q, $i, $j, $i_quo_p, $i_rem_p, $j_quo_q, $j_rem_q);

for $test (1, 2) {
	
	if ($test == 1) {   # Mohammad's example

		$A = [[ 1, 2 ],
			  [ 3, 4 ]];

		$B = [[ 5, 6 ],
			  [ 7, 8 ]];
			  
	} else {   # Wikipedia's 2nd example

		$A = [[ 1, -4, 7],
			  [-2,  3, 3]];
			  
		$B = [[8, -9, -6,  5],
			  [1, -3, -4,  7],
			  [2,  8, -8, -3],
			  [1,  2, -5, -1]];
	}
	
	# display input
	show('A', $A);
	show('B', $B);
		  
	$m = scalar(@$A);			# no of rows in A (0 to $m - 1)
	$n = scalar(@{$A->[0]});   	# no of columns in A
	$p = scalar(@$B);			# no of rows in B 
	$q = scalar(@{$B->[0]});	# no of columns in B

	# loop over the rows and cols of product matrix $K ($m * $p rows, $n * $q cols)
	for $i (0 .. $m * $p - 1) {
		for $j (0 .. $n * $q - 1) {
			
			# get the quotient and remainder on dividing i by p and j by q
			($i_quo_p, $i_rem_p) = quorem($i, $p);
			($j_quo_q, $j_rem_q) = quorem($j, $q);
			
			# Wikipedia formula for element i, j of K
			$K->[$i]->[$j] = $A->[$i_quo_p]->[$j_quo_q] * $B->[$i_rem_p]->[$j_rem_q];
		}
	}
	
	# display the result
	show('A x B', $K);
	print qq[-----\n\n];
}
		
sub quorem {

	my ($dividend, $divisor, $quotient, $remainder);

	# returns the integer quotient and remainder from dividend / divisor (both integers > 0)
	$dividend = shift;
	$divisor = shift;
	
	$quotient = int($dividend / $divisor);
	$remainder = $dividend - $quotient * $divisor;
	
	return ($quotient, $remainder);
}

sub show {
	
	my ($caption, $M, $margin, $i, $j, $this_width, $cell_width);
	
	# pretty print matrix
	($caption, $M) = @_;
	
	$caption .= ' = ';
	$margin = length($caption);
	
	# first pass to get width of cells
	$cell_width = 0;
	for $i (0 .. scalar(@$M) - 1) {
		for $j (0 .. scalar(@{$M->[0]}) - 1) {
			$this_width = length($M->[$i]->[$j]);
			$cell_width = $this_width if $this_width > $cell_width;
		}
	}
	$cell_width += 1;
	
	# second pass to print out - loop over rows
	for $i (0 .. scalar(@$M) - 1) {
		print qq{$caption\[};       # first line
		$caption = ' ' x $margin;   # subsequent lines
		
		# and over columns, padding each value to $cell_width
		for $j (0 .. scalar(@{$M->[0]}) - 1) {
			printf("%${cell_width}s", $M->[$i]->[$j]);
		}
		print qq[ \]\n];
	}
	print qq[\n];
}
