#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-23
use utf8;     # Week 288 - task 2 - Contiguous block
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($matrix, $last_x, $last_y, @count, $number, $symbol);

contiguous_block(
[['x', 'x', 'x', 'x', 'o'],
 ['x', 'o', 'o', 'o', 'o'],
 ['x', 'o', 'o', 'o', 'o'],
 ['x', 'x', 'x', 'o', 'o']]);
 
contiguous_block(
[['x', 'x', 'x', 'x', 'x', 'x'],
 ['x', 'o', 'o', 'o', 'o', 'o'],
 ['x', 'x', 'x', 'x', 'x', 'x'],
 ['o', 'o', 'o', 'o', 'o', 'x'],
 ['o', 'x', 'x', 'x', 'o', 'x'],
 ['x', 'o', 'o', 'o', 'o', 'x'],
 ['x', 'x', 'x', 'x', 'x', 'x']]); 

sub contiguous_block {
	
	my ($x, $y, $most, $block, $j);
	
	$matrix = shift;
	print_matrix(qq[Input: ], $matrix);
	$last_x = @$matrix - 1;
	$last_y = @{$matrix->[0]} - 1;
	$number = 0;
	@count = ();
	
	# loop over cells
	for $x (0 .. $last_x) {
		for $y (0 .. $last_y) {

			# if cell contains a number, skip it
			next if $matrix->[$x]->[$y] =~ m|^\d+$|;
			$symbol = $matrix->[$x]->[$y];
			
			# else number it
			$matrix->[$x]->[$y] = ++ $number;
			$count[$number] ++;
			
			# and number all its unnumbered neighbours recursively
			number_neighbours($x, $y);
		}
	}
	
	# find largest
	$most = 0;
	for $j (1 .. @count - 1) {
		if ($count[$j] > $most) {
			$most = $count[$j];
			$block = $j;
		}
	}
	say qq[\nOutput: largest block size is $most (block $block)];	
	print_matrix(qq[Blocks:], $matrix);
	say qq[-----];
}

sub number_neighbours {
	
	my ($x, $y, $xx, $yy, $neighbour);
	
	($x, $y) = @_;
	
	# cells above, below, left and right of $x, $y
	for $neighbour (1 .. 4) {
		if    ($neighbour == 1) {$xx = $x - 1; $yy = $y    }
		elsif ($neighbour == 2) {$xx = $x;     $yy = $y + 1}
		elsif ($neighbour == 3) {$xx = $x;     $yy = $y - 1}
		elsif ($neighbour == 4) {$xx = $x + 1; $yy = $y    }
		next if ($xx < 0 or $xx > $last_x or $yy < 0 or $yy > $last_y);
		
		# number them the same if they are not already numbered
		if ($matrix->[$xx]->[$yy] eq $symbol) {
			$matrix->[$xx]->[$yy] = $number;
			$count[$number] ++;
			number_neighbours($xx, $yy);
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
