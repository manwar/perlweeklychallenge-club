#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-22
use utf8;     # Week 218 task 2 - Matrix score
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

matrix_score( [ [0,0,1,1],
                [1,0,1,0],
                [1,1,0,0] ]);
matrix_score( [ [0] ]);
matrix_score( [ [0, 0, 0, 0, 1],
				[0, 1, 0, 0, 0],
				[0, 0, 0, 1, 0],
				[0, 0, 1, 0, 0] ]);


sub matrix_score {
	
	my ($matrix, $last_row, $last_col, $row, $col, $sum, $value);
	
	# initialise
	$matrix = $_[0];
	say '';
	show_matrix(qq{Input:  }, $matrix);
	$last_row = scalar @$matrix - 1;
	$last_col = scalar @{$matrix->[0]} - 1;
	
	# flip rows so that column 1 is 1
	for $row (0 .. $last_row) {
		if ($matrix->[$row]->[0] == 0 ) {
			for $col (0 .. $last_col) {
				$matrix->[$row]->[$col] = 1 - $matrix->[$row]->[$col];
			}
		}
	}
	
	# flip columns to maximise no of 1s
	for $col (1 .. $last_col) {
		$sum = 0;
		for $row (0 .. $last_row) {
			$sum += $matrix->[$row]->[$col];
		}
		if ($sum < ($last_row + 1) / 2) {
			for $row (0 .. $last_row) {
				$matrix->[$row]->[$col] = 1 - $matrix->[$row]->[$col];
			}
		}
	}
	
	# evaluate
	$value = 2 ** $last_col;
	$sum = 0;
	for $col (0 .. $last_col) {
		for $row (0 .. $last_row) {
			$sum += $matrix->[$row]->[$col] * $value;
		}
		$value /= 2;
	}
	
	say '';
	show_matrix(qq[Output: ], $matrix);
	say qq[        sum = $sum];
}

sub show_matrix {
	
	my ($intro, $row, $matrix, $last_row); 	
	($intro, $matrix) = @_;
	
	# print out a matrix
	$last_row = scalar @$matrix - 1;
	for $row (0 .. $last_row) {
		say qq{$intro\[ } . join(', ', @{$matrix->[$row]}) . ' ]';
		$intro = ' ' x length($intro);
	}

}

