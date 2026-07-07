#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/381/1

use v5.26;    # The Weekly Challenge - 2026-07-06
use utf8;     # Week 381 - task 1 - Same row column
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

same_row_column([[1, 2, 3, 4],
                 [2, 3, 4, 1],
                 [3, 4, 1, 2],
                 [4, 1, 2, 3]]);
				 
same_row_column([[1]]);

same_row_column([[1, 2, 5],
                 [5, 1, 2],
                 [2, 5, 1]]);
				 
same_row_column([[1, 2, 3],
                 [1, 2, 3],
                 [1, 2, 3]]);
				 
same_row_column([[1, 2, 3],
				 [3, 1, 2],
				 [1, -1, 77]]);

sub same_row_column {
	
	my ($matrix, @good, $m, $row, $col, $in_row, $in_col, $value, $test);
	
	# initialise
	$matrix = shift;
	$m = scalar @$matrix - 1;  # $m == $n - 1
	print_matrix($matrix, $m, qq[Input: ]);

	# survey matrix
	for $row (0 .. $m) {
		for $col (0 .. $m) {
			$value = $matrix->[$row]->[$col];
			unless ($value >= 1 and $value <= $m + 1) {
				say qq[Output: false - out of range value: $value];
				return;
			}
			if ($in_row->[$row]->[$value] or 
				$in_col->[$col]->[$value]) {
				say qq[Output: false - duplicated value: $value];
				return;
			}	
			$in_row->[$row]->[$value] = $in_col->[$col]->[$value] = 1;
		}
	}
	
	# otherwise ...
	say qq[Output: true];
}

sub print_matrix {
	
	my ($matrix, $cols, $legend, $row, $rows);
	
	# print array as a matrix with $cols columns
	($matrix, $cols, $legend) = @_;
	$rows = $cols;
	say '';
	for $row (0 .. $rows) {
		say qq{$legend [} . join(', ', @{$matrix->[$row]}) . ']'
				. ($row < $rows ? ',' : '');
		$legend = ' ' x length($legend);
	}
}

