#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-27
use utf8;     # Week 271 - task 1 - Maximum ones
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

maximum_ones([[0, 1], [1, 0]]);
maximum_ones([[0, 0, 0], [1, 0, 1]]);
maximum_ones([[0, 0], [1, 1], [0, 0]]);
maximum_ones([[2, 3], [4, 1], [5, 6], [7, 1]]);
maximum_ones([[3, 3, 3], [4, 4, 4], [0, 0, 0]]);

sub maximum_ones {
	
	my ($matrix, $max, $ones, $max_row, $r);
	
	# initialise
	$matrix = shift;
	$max = -1;
	
	# loop over rows
	for $r (0 .. @$matrix - 1) {
		$ones = grep {$_ == 1 ? 1 : 0} @{$matrix->[$r]};
		
		# found a better one
		if ($ones > $max) {
			$max_row = $r;
			$max = $ones;
		}
	}
	
	# show result
	print_matrix('Input: ', $matrix);
	printf  $max > 0 ? (qq[Output: row %d (%d one%s)\n], $max_row + 1, $max, $max == 1 ? '' : 's') :
		qq[Output: no ones in matrix\n];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format matrix
	($legend, $matrix) = @_;
	say '';
	for $j (0 .. @$matrix - 1) {
		say qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		$legend = ' ' x length($legend);
	}
}
