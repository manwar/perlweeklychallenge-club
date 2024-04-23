#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-22
use utf8;     # Week 266 - task 2 - X matrix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

x_matrix([ [1, 0, 0, 2],
           [0, 3, 4, 0],
           [0, 5, 6, 0],
           [7, 0, 0, 1] ]);
		   
x_matrix([ [0, 2, 0],
           [4, 0, 6],
           [0, 8, 0] ]);
		   
x_matrix([ [1, 0, 0, 0, 1],
           [0, 2, 0, 2, 0],
		   [0, 0, 3, 0, 0],
		   [0, 4, 0, 4, 0],
           [5, 0, 0, 0, 0] ]);
		   
x_matrix([ [1, 0, 2],
           [0, 3, 0],
           [4, 0, 5] ]);
				 
sub x_matrix {
	
	my ($matrix, $dimension, $x, $y);
	
	# initialise
	$matrix = shift;
	$dimension = scalar @$matrix - 1;
	print_matrix(qq[Input: ], $matrix);
	
	# loop over matrix elements
	for $x (0 .. $dimension) {
		for $y (0 .. $dimension) {
			
			# conditions that must be met
			next if ($x == $y or $x == $dimension - $y) ?
				$matrix->[$x]->[$y] != 0 : $matrix->[$x]->[$y] == 0;
			
			# ... but they are not
			say qq[Output: false (∵ matrix[$x, $y] == $matrix->[$x]->[$y])];
			return;
		}
	}
	
	# all values are good
	say qq[Output: true];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format rows of matrix
	($legend, $matrix) = @_;
	say '';
	for $j (0 .. @$matrix - 1) {
		say qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		$legend = ' ' x length($legend);
	}
}
