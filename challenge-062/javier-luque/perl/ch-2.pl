#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

# Size of board
my $size = $ARGV[0] || 6;

# Store best solution
our $bs_board       = init_board( $size );
our $bs_queen_count = 0;

# Our Playing board
my $board = init_board( $size );
if (nqueens($board, 0, 0, 0)) {
    say "Real Solution:\n";
    say display_board($board);
} else {
    say "Best Solution:\n";
    say display_board($bs_board);
}

# Nqueens algorithm
sub nqueens {
    my ($board, $next_z, $next_col, $placed) = @_;
    my $size = scalar(@$board);
    my $index = $next_z * $size + $next_col;

    # We found a solution
    return 1
    	if $index > ($size * $size) - 1 ;

    # We've moved to the next level
    if ($next_col > $size - 1) {
    	$next_z++;
    	$next_col -= $size;
    };

    # Backtrack till we find a solution
    for my $row (0 .. $size - 1) {
    	if (valid_placement($board, $size, $next_z, $row, $next_col)) {
    		$board->[$next_z]->[$row]->[$next_col] = 1;

    		# Queen placed
    		$placed++;

    		# Current best solution
    		if ($bs_queen_count < $placed) {
    			copy_board($board, $bs_board);
    			$bs_queen_count = $placed;
    		}

    		# Solution found
    		return 1
    			if (nqueens($board, $next_z, $next_col + 1, $placed));

    		# Backtrack
    		$placed--;
    		$board->[$next_z]->[$row]->[$next_col] = 0;
    	}
    }

    # If we get here there is no
    # possible solution to this chain
    return 0;
}

# Check valid placements
sub valid_placement {
    my ($board, $size, $height, $row, $col) = @_;

    # Check rows
    for (my $i = 0; $i < $col; $i++) {
    	return 0
    		if ($board->[$height]->[$row]->[$i]);
    }

    # Check 2d upper left diagonals
    my $i = $row; my $j = $col;
    while ($i >= 0 && $j >= 0) {
    	return 0
    		if ($board->[$height]->[$i]->[$j]);
    	$i--; $j--;
    }

    # Check 2d lower right
    $i = $row; $j = $col;
    while ($i <= $size && $j >= 0) {
    	return 0
    		if ($board->[$height]->[$i]->[$j]);
    	$i++; $j--;
    }

    # Check lower z
    for (my $k = $height - 1; $k >= 0; $k--) {
    	my $range = $height - $k;

    	for my $i (-$range, 0, $range) {
    		for my $j (-$range, 0, $range) {
    			my $a = $row + $i ;
    			my $b = $col + $j;

    			# Out of bound;
    			next if ($a < 0 || $b < 0);
    			next if ($a >= $size || $b >= $size);

    			return 0
    				if ($board->[$k]->[$a]->[$b]);
    		}
    	}
    }


    # Return true if we don't
    # collide with another queen
    return 1;
}

# Initializes the board
sub init_board {
    my $size = (shift) - 1;
    my @board;

    for my $i (0 .. $size) {
    	for my $j (0 .. $size) {
    		for my $k (0 .. $size) {
    			$board[$i][$j][$k] = 0;
    		}
    	}
    }

    return \@board;
}

# Displays the board
sub display_board {
    my $board = shift;
    my $size = scalar (@$board);

    # Store the board string into $b
    my $b;
    for my $k (0 .. $size - 1) {
    	$b .= "z = $k\n";
    	$b .= '|' . '-' x (4 * $size - 1) . '|' . "\n";
    	for my $i (0 .. $size - 1) {
    		$b .= '|';
    		for my $j (0 .. $size - 1) {
    			my $space = ($board->[$k]->[$i]->[$j] == 1) ?
    			            '*' : ' ';
    			$b .= " $space |"
    		}
    		$b .= "\n";
    	}
    	$b .= '|' . '-' x (4 * $size - 1) . '|' . "\n\n";
    }

    # Return the board representation
    return $b;
}

# Copy board
sub copy_board {
    my ($src, $copy) = @_;
    my $size = scalar(@$src) - 1;

    for my $i (0 .. $size) {
    	for my $j (0 .. $size) {
    		for my $k (0 .. $size) {
    			$copy->[$i]->[$j]->[$k] =
    				$src->[$i]->[$j]->[$k];
    		}
    	}
    }
}
