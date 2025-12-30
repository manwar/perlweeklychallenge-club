#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-29
use utf8;     # Week 354 - task 2 - Shift grid
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

shift_grid(1, [1, 2, 3], [4, 5, 6], [7, 8, 9]);
shift_grid(1, [10, 20], [30, 40]);
shift_grid(1, [1, 2], [3, 4], [5, 6]);
shift_grid(5, [1, 2, 3], [4, 5, 6]);
shift_grid(1, [1, 2, 3, 4]);
shift_grid(7, [11, 12, 13, 14, 15], [16, 17, 18, 19, 20], 
	[21, 22, 23, 24, 25]);

sub shift_grid {
	
	my ($shifts, @nums, $cols);
	
	# concatenate the input strings
	$shifts = shift @_;
	push @nums, @$_ for @_;
	$cols = @{$_[0]};
	
	say '';
	print_matrix(\@nums, $cols, qq[Input:  ]);
	say qq[         \$k = $shifts];
	
	# and the last shall be first
	unshift(@nums, (pop @nums)) for 1 .. $shifts;
	
	print_matrix(\@nums, $cols, qq[Output: ]);
}

sub print_matrix {
	
	my ($matrix, $cols, $legend, $row, $rows) = @_;

	# print array as a matrix with $cols columns
	$rows = @$matrix / $cols - 1;
	for $row (0 .. $rows) {
		say qq{$legend [} . 
			join(', ', @$matrix[$row * $cols .. ($row + 1) * $cols - 1]) . 
			']' . ($row < $rows ? ',' : '');
		$legend = ' ' x length($legend);
	}
}