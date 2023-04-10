#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-03
use utf8;     # Week 211 task 1 - Toeplitz matrix
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

toeplitz_matrix( [[4, 3, 2, 1],
				  [5, 4, 3, 2],
				  [6, 5, 4, 3]] );
				  
toeplitz_matrix( [[4, 3, 2, 1],
				  [5, 4, 3, 2],
				  [6, 5, 4, 7]] );

toeplitz_matrix( [[37.1, 114, 0, -23.65, 5, 3],
				  [-40, 37.1, 114, 0, -23.65, 5],
				  [-19, -40, 37.1, 114, 0, -23.65],
				  [3, -19, -40, 37.1, 114, 0],
				  [55, 3, -19, -40, 37.1, 114],
				  [0, 55, 3, -19, -40, 37.1],
				  [999, 0, 55, 3, -19, -40]] );
				  
toeplitz_matrix( [[6, 0, 0, 0, 6],
				  [0, 0, 6, 0, 0],
				  [6, 0, 0, 0, 6]] );
		
sub toeplitz_matrix {
	
	my($m, $r, $c, $x, $good);
	
	$m = $_[0];
	
	# loop over rows and then columns
	ROW: for $r (1 .. scalar @$m - 1) {
		for $c (1. .. scalar @{$m->[0]} - 1) {
			
			# check each element against the appropriate edge element
			$x = $m->[$r]->[$c];
			if ($r >= $c) {
				$good = $x == $m->[$r - $c]->[0] ? 1 : 0;
				last ROW unless $good;
			} else {
				$good = $x == $m->[0]->[$c - $r] ? 1 : 0;
				last ROW unless $good;
			}
		}
	}
	
	# format the output
	my ($w, $width, $rubric, $prefix, $spaces);
	
	# find maximum width of element (as printed by Perl)
	$w = 0;
	for $r (0 .. scalar @$m - 1) {
		for $c (0. .. scalar @{$m->[0]} - 1) {
			$width = length($m->[$r]->[$c]);
			$w = $width if $width > $w;
		}
	}
	
	# construct and output each row of matrix
	$rubric = '';
	$prefix = qq{\nInput: \@matrix = [ [ };
	for $r (0 .. scalar @$m - 1) {
		$rubric .= $prefix;
		for $c (0. .. scalar @{$m->[0]} - 1) {
			$spaces = $w + 1 - length($m->[$r]->[$c]);
			$rubric .= (' ' x $spaces) . $m->[$r]->[$c] . ',';
		}
		$rubric =~ s|.$| ]|s;
		$rubric .= ' ]' if $r == scalar @$m - 1;
		say $rubric;
		$rubric = '';
		$prefix = '                   [ ';
	}
	say qq[Output: ] . ($good ? 'true' : 'false');
}

