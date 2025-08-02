#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-20
use utf8;     # Week 270 - task 1 - Special positions
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

special_positions([[1, 0, 0],
                   [0, 0, 1],
                   [1, 0, 0]]);
				   
special_positions([[1, 0, 0],
                   [0, 0, 1],
                   [0, 0, 1]]);

special_positions([[1, 0, 1],
                   [0, 0, 0],
                   [1, 0, 1]]);
				   
special_positions([[1, 0, 0, 0, 0, 0],
				   [0, 1, 0, 0, 0, 0],
				   [0, 0, 1, 0, 0, 0],
				   [0, 0, 0, 1, 0, 0],
				   [0, 0, 0, 0, 1, 1]]);

sub special_positions {
	
	my ($matrix, $ones, $r, $c, $special, $r1, $c1, $count);
	
	$matrix = shift;
	$special = '';
	
	# look for 1s
	ROW: for $r (0 .. @$matrix - 1) {
		COL: for $c (0 .. @{$matrix->[$r]} - 1) {
			next COL unless $matrix->[$r]->[$c] == 1;
			
			# check that it's the only 1 in its row
			for $r1 (0 .. @$matrix - 1) {
				next COL if ($matrix->[$r1]->[$c] != 0 and $r1 != $r);
			}
			
			# and in its column
			for $c1 (0 .. @{$matrix->[$r]} - 1) {
				next COL if ($matrix->[$r]->[$c1] != 0 and $c1 != $c); 
			}
			
			# found one!
			$special .= qq[r$r c$c, ];
		}
	}
	
	# count the commas and show answer
	$count = $special =~ s|,|,|g + 0;
	print_matrix(q[Input: ], $matrix);
	say qq[Output: $count] . ($count > 0 ? ' - ' . substr($special, 0, -2) : '');
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
