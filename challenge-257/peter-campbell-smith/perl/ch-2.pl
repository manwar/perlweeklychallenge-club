#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-19
use utf8;     # Week 257 - task 2 - Reduced row echelon
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

reduced_row_echelon([[1, 1, 0],
                     [0, 1, 0],
                     [0, 0, 0]]);
				  
reduced_row_echelon([[0, 1,-2, 0, 1],
                     [0, 0, 0, 1, 3],
                     [0, 0, 0, 0, 0],
                     [0, 0, 0, 0, 0]]);
					 
reduced_row_echelon([[1, 0, 0, 4],
					 [0, 1, 0, 7],
                     [0, 0, 1,-1]]);
					 
reduced_row_echelon([[0, 1,-2, 0, 1],
                     [0, 0, 0, 0, 0],
                     [0, 0, 0, 1, 3],
                     [0, 0, 0, 0, 0]]);
				 
reduced_row_echelon([[0, 1, 0],
                     [1, 0, 0],
                     [0, 0, 0]]);
				  
reduced_row_echelon([[4, 0, 0, 0],
                     [0, 1, 0, 7],
                     [0, 0, 1,-1]]);
				  
sub reduced_row_echelon {
	
	my ($M, $result, $row, $cell, $fnz, @zero_rows, $last_row, $row_no, $z, 
		$col_no, $prev_col_no, $this_row_no, $rows);
	
	$M = shift;
	print_matrix(qq(\nInput:  [), $M);
	$result = 1;
	
	# 1. If a row does not consist entirely of zeros, 
	# then the first nonzero number in the row is a 1. 
	# We call this the leading 1.
	
	ROW1: for $row_no (0 .. @$M - 1) {
		$row = $M->[$row_no];
		undef $fnz;
		CELL1: for $cell (@$row) {
			next CELL1 unless $cell;
			
			# find first non-zero cell in each row and check it's 1
			$fnz = $cell if $cell != 0;
			if ($fnz == 1) {
				next ROW1;
			} else {
				say qq[Output: 0 - row $row_no breaks rule 1 (rows numbered from 0)];
				return;
			}
		}
	}
	
	# 2. If there are any rows that consist entirely of 
	# zeros, then they are grouped together at the bottom 
	# of the matrix.
	
	$rows = @$M;
	@zero_rows = ();
	ROW2: for $row_no (0 .. $rows - 1) {
		$row = $M->[$row_no];
		CELL2: for $cell (@$row) {
			next ROW2 if $cell != 0;
		}
		push @zero_rows, $row_no;
	}
	
	# check the all-zero rows are all at the bottom
	for $z (@zero_rows) {
		if ($z <  $rows - @zero_rows) {
			say qq[Output: 0 - row $z breaks rule 2 (rows numbered from 0)];
			return;
		}
	}
	
	# 3. In any two successive rows that do not consist entirely of zeros,
	# the leading 1 in the lower row occurs farther to the right than
	# the leading 1 in the higher row.
	
	$prev_col_no = -1;
	ROW3: for $row_no (0 .. $rows - 1 - @zero_rows) {
		$row = $M->[$row_no];
		CELL3: for $col_no (0 .. @$row - 1) {
			$cell = $M->[$row_no]->[$col_no];
			if ($cell == 1) {
				
				# check that the 1 is to the right of the preceding 1
				if ($col_no <= $prev_col_no) {
					say qq[Output: 0 - row $row_no breaks rule 3 (rows numbered from 0)];
					return;
				} else {
					$prev_col_no = $col_no;
					next ROW3;
				}
			}
		}
	}

	# 4. Each column that contains a leading 1 has zeros everywhere else
	# in that column.

	ROW4: for $row_no (1 .. @$M - 1 - @zero_rows) {
		CELL4: for $col_no (0 .. @$row) {
			$cell = $cell = $M->[$row_no]->[$col_no];
			next CELL4 unless $cell;
			
			# check the rows above this 1 are all zero
			for $this_row_no (0 .. $row_no - 1) {
				if ($M->[$this_row_no]->[$col_no] != 0) {
					say qq[Output: 0 - column $col_no breaks rule 4 (columns numbered from 0)];
					return;
				}
			}
			next ROW4;			
		}
	}
	
	say qq[Output: 1 - matrix is in reduced row echelon form];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format rows of matrix
	($legend, $matrix) = @_;
	for $j (0 .. @$matrix - 1) {
		say qq[$legend] . join(', ', @{$matrix->[$j]}) . qq(]);
		$legend = '        [';
	}
}