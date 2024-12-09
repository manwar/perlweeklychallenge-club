#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-09
use utf8;     # Week 299 - task 2 - Word search
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($end, $x_max, $y_max);

word_search([['A', 'B', 'D', 'E'],
             ['C', 'B', 'C', 'A'],
             ['B', 'A', 'A', 'D'],
             ['D', 'B', 'B', 'C']], 'BDCA');

word_search([['A', 'B', 'D', 'E'],
             ['C', 'B', 'C', 'A'],
             ['B', 'A', 'A', 'D'],
             ['D', 'B', 'B', 'C']], 'BDCF');
			 
word_search([['A', 'P', 'R', 'E'],
             ['C', 'R', 'U', 'S'],
             ['B', 'I', 'A', 'D'],
             ['E', 'S', 'B', 'C']], 'SURPRISE');
			 
word_search([['W', 'Y', 'C', 'E', 'N'],
             ['E', 'L', 'H', 'L', 'G'],
             ['E', 'K', 'A', 'L', 'E']], 'WEEKLYCHALLENGE');

sub word_search {
	
	my ($chars, $str, @grid, $x, $y, $save);
	
	# initialise
	($chars, $str) = @_;
	$y_max = @$chars - 1;
	$x_max = @{$chars->[0]} - 1;
	$end = '';
	print_matrix('Input: @chars = ', $chars);
	say qq[       \$str =    $str];
	
	# make @grid
	for $x (0 .. $x_max) {
		for $y (0 .. $y_max) {
			$grid[$y][$x] = $chars->[$y]->[$x];
		}
	}
	
	# find all locations of the first letter
	SEARCH: for $x (0 .. $x_max) {
		for $y (0 .. $y_max) {
			if ($grid[$y][$x] eq substr($str, 0, 1)) {
				
				# blank it out and look for the rest
				$save = $grid[$y][$x];
				$grid[$y][$x] = '*';
				keep_searching(\@grid, substr($str, 1), $x, $y);
				
				# success!
				if ($end) {
					say qq[Output: true, from ($x, $y) $end];					
					last SEARCH;
				}
				$grid[$y][$x] = $save;
			}
		}
	}
	say qq[Output: false] unless $end;
}

sub keep_searching {
	
	my (@grid, $str, $x, $y, $xx, $yy, $save);
	
	# recursive search for next letter
	@grid = @{$_[0]};
	$str = $_[1];
	($x, $y) = ($_[2], $_[3]);
	
	# check cells above, below, left and right (if they exist)
	for $xx ($x - 1 .. $x + 1) {
		for $yy ($y - 1 .. $y + 1) {
			next if ($xx < 0 or $yy < 0 or $xx > $x_max or $yy > $y_max);
			next unless ($xx == $x or $yy == $y);
			
			# do they contain the next letter?
			if ($grid[$yy][$xx] eq substr($str, 0, 1)) {
				
				# have we found all the letters yet?
				if (length($str) == 1) {
					$end = qq[to ($xx, $yy)];
					return;
				}
				
				# no, so recurse to find the rest
				$save = $grid[$yy][$xx];
				$grid[$yy][$xx] = '*';
				keep_searching(\@grid, substr($str, 1), $xx, $yy);
				$grid[$yy][$xx] = $save;
			}
		}
	}
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
