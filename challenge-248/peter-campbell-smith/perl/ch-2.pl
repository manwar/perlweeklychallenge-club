#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-12-18
use utf8;     # Week 242 task 2 - Submatrix sum
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

submatrix_sum([1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]);
submatrix_sum([37, 99, 43, 87, 22, 77,  0, 51, 20],
              [18,  5, 67, 39, 52, 40, 39, 77,  1],
			  [93, 45, 34, 87, 12, 34, 15, 90, 22],
			  [11, 84, 45, 36, 75, 83, 40, 58, 89]);

sub submatrix_sum {
	
	my ($in, $cols, $rows, $c, $r, $out, $chars, $max);
	
	# initialise
	$in = \@_;
	$cols = @{$in->[0]} - 1;
	$rows = @$in - 1;
	$max = 0;
	
	# loop over rows and columns calculating sum
	for $r (0 .. $rows - 1) {
		for $c (0 .. $cols - 1) {
			$out->[$r]->[$c] = $in->[$r]->[$c] + $in->[$r + 1]->[$c] + 
				$in->[$r]->[$c + 1] + $in->[$r + 1]->[$c + 1];
			$chars = length($out->[$r]->[$c]);
			$max = $chars if $chars > $max;
		}
	}
	
	# output the required data
	print_matrix('Input:  [', $in, $max);
	print_matrix('Output: [', $out, $max);
}


sub print_matrix {
	
	my ($legend, $matrix, $j, $out, $max);

	($legend, $matrix, $max) = @_;
	
	# format rows of matrix	with numbers of equal width
	$out = '';
	for $j (0 .. @$matrix - 1) {
		$out .= qq[$legend] . join(', ', @{$matrix->[$j]}) . qq(]\n);
		$legend = '        [';
	}
	$out =~ s|(\d+)|sprintf("%${max}d", $1)|ge;
	say $out;
}
		