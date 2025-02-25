#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-02
use utf8;     # Week 298 - task 1 - Maximal square
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

maximal_square([[1, 0, 1, 0, 0],
                [1, 0, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 0, 0, 1, 0]]);
				
maximal_square([[1, 0, 1, 0, 0],
                [1, 0, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 0, 1, 1, 1],
				[0, 1, 0, 1, 0]]);

maximal_square([[1, 0, 1, 1],
                [0, 1, 0, 1],
                [1, 0, 1, 0],
                [1, 0, 1, 1]]);
				
maximal_square([[0, 0],
                [0, 0]]);
				
sub maximal_square {
	
	my ($m, $w, $h, $s, $q, $x, $y, $xx, $yy, $top_left);
	$m = shift;
	
	$h = @$m;               # height
	$w = @{$m->[0]};        # width
	$s = $w > $h ? $h : $w; # max possible square side
	$top_left = '';
	
	# loop over possible sizes, largest to smallest
	SIZES: for ($q = $s; $q > 0; $q --) {
	
		# loop over all possible top-left x and y
		for $x (0 .. $w - $q) {
			TOPLEFT: for $y (0 .. $h - $q) {
				
				# now check if this is the top left of 
				# a $q-sided square
				for $xx ($x .. $x + $q - 1) {
					for $yy ($y .. $y + $q - 1) {
						next TOPLEFT unless $m->[$yy]->[$xx] == 1;
					}
				}
				
				# found a square!
				$top_left = qq[$x, $y];
				last SIZES;
			}
		}
	}
	print_matrix('Input: ', $m);
	say qq[Output: ] . ($top_left ? (($q * $q) . 
	   qq[ (top left at $top_left)]) : '0');
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
