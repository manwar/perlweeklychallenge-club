#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-08
use utf8;     # Week 338 - task 1 - Highest row
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

highest_row(([4, 4, 4, 4], [10, 0, 0, 0], [2,  2, 2, 9]));
highest_row(([1, 5], [7, 3], [3, 5]));
highest_row(([1, 2, 3], [3, 2, 1]));
highest_row(([10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]));
highest_row(([-1, -2, -3], [-4, -5, -6], [-7, -8, -9]));

sub highest_row {
	
	my (@matrix, $highest, $row_sum, $row);
	
	# initialise
	@matrix = @_;
	$highest = -Inf;
	
	# find row sums
	for $row (0 .. scalar @matrix - 1) {
		$row_sum = 0;
		$row_sum += $_ for @{$matrix[$row]};
		$highest = $row_sum if $row_sum > $highest;
	}
	
	# report
	say '';
	print_matrix(qq[Input: ], \@matrix);
	say qq[Output: $highest];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format matrix
	($legend, $matrix) = @_;
	for $j (0 .. @$matrix - 1) {
		print qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		say $j == @$matrix - 1 ? '' : ', ';
		$legend = ' ' x length($legend);
	}
}