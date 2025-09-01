#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-01
use utf8;     # Week 337 - task 2 - Odd matrix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

odd_matrix(2, 3, [[0, 1], [1, 1]]);
odd_matrix(2, 2, [[1, 1], [0, 0]]);
odd_matrix(3, 3, [[0, 0], [1, 2], [2, 1]]);
odd_matrix(1, 5, [[0, 2], [0, 4]]);
odd_matrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]);
odd_matrix(5, 5, [[0, 0], [4, 4]]);

sub odd_matrix {
	
	my ($rows, $cols, $locations, @cells, $cell, $row, $col, $legend, $input, $odds);
	
	# initialise
	($rows, $cols, $locations) = @_;	
	$cells[$_] = 0 for 0 .. $rows * $cols - 1;
	
	# loop over locations
	for $cell (@$locations) {
		($row, $col) = @$cell;
		
		# increment row and col
		$cells[$_ + $row * $cols] ++ for 0 .. $cols - 1;
		$cells[$col + $_ * $cols] ++ for 0 .. $rows - 1;
		$input .= qq{[$row, $col], };
	}
	$odds = scalar(grep { $_ & 1 == 1} @cells);

	# report
	say qq{\nInput:  \$rows = $rows, \$cols = $cols, \@locations = [} .
		substr($input, 0, -2) . ']';
	say qq[Output: $odds odd value] . ($odds == 1 ? '' : 's');	
	for $row (0 .. $rows - 1) {
		print '        [ ';
		print $cells[$_ + $row * $cols] . ' ' for 0 .. $cols - 1;
		say ']';
	}			
}
