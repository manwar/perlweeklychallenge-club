# Test: perl6 ch-2.p6
# Store best solution
our @bs_board;
our $bs_queen_count = 0;

multi MAIN() {
    MAIN(6);
}

multi MAIN(Int $size) {
    @bs_board = init-board( $size );

    # Our Playing board
    my @board = init-board( $size );
    if (nqueens(@board, 0, 0, 0)) {
    	say "Real Solution:\n";
    	say display-board(@board);
    } else {
    	say "Best Solution:\n";
    	say display-board(@bs_board);
    }
}

# Nqueens algorithm
sub nqueens(@board, Int $next_z is copy, Int $next_col is copy, Int $placed is copy) {
    my $size = @board.elems;
    my $index = $next_z * $size + $next_col;

    # We found a solution
    return True
    	if $index > ($size * $size) - 1 ;

    # We've moved to the next level
    if ($next_col > $size - 1) {
    	$next_z++;
    	$next_col -= $size;
    };

    # Backtrack till we find a solution
    for (0 .. $size - 1) -> $row {
    	if (valid-placement(@board, $size, $next_z, $row, $next_col)) {
    		@board[$next_z][$row][$next_col] = 1;

    		# Queen placed
    		$placed++;

    		# Current best solution
    		if ($bs_queen_count < $placed) {
    			copy-board(@board, @bs_board);
    			$bs_queen_count = $placed;
    		}

    		# Solution found
    		return True
    			if (nqueens(@board, $next_z, $next_col + 1, $placed));

    		# Backtrack
    		$placed--;
    		@board[$next_z][$row][$next_col] = 0;
    	}
    }

    # If we get here there is no
    # possible solution to this chain
    return False;
}

# Check valid placements
sub valid-placement(@board, Int $size, Int $height, Int $row, Int $col) {
    my ($i, $j, $k);

    # Check rows
    loop ($i = 0; $i < $col; $i++) {
    	return False
    		if (@board[$height][$row][$i]);
    }

    # Check 2d upper left diagonals
    $i = $row; $j = $col;
    while ($i >= 0 && $j >= 0) {
    	return False
    		if (@board[$height][$i][$j]);
    	$i--; $j--;
    }

    # Check 2d lower right
    $i = $row; $j = $col;
    while ($i <= $size && $j >= 0) {
    	return False
    		if (@board[$height][$i][$j]);
    	$i++; $j--;
    }

    # Check lower z
    loop ($k = $height - 1; $k >= 0; $k--) {
    	my $range = $height - $k;

    	for (-$range, 0, $range) -> $i {
    		for (-$range, 0, $range) -> $j {
    			my $a = $row + $i;
    			my $b = $col + $j;

    			# Out of bound;
    			next if ($a < 0 || $b < 0);
    			next if ($a >= $size || $b >= $size);

    			return False
    				if (@board[$k][$a][$b]);
    		}
    	}
    }

    # Return true if we don't
    # collide with another queen
    return True;
}


# Initializes the board
sub init-board(Int $size) {
    my @board;

    for (0 .. $size - 1) -> $i {
    	for (0 .. $size - 1) -> $j {
    		for (0 .. $size - 1) -> $k {
    			@board[$i][$j][$k] = 0;
    		}
    	}
    }

    return @board;
}

# Dislays the board
sub display-board(@board) {
    my $size = @board.elems;

    # Store the board string into $b
    my $b;
    for (0 .. $size - 1) -> $k {
    	$b ~= "z = $k\n";
    	$b ~= '|' ~ '-' x (4 * $size - 1) ~ '|' ~ "\n";
    	for (0 .. $size - 1) -> $i {
    		$b ~= '|';
    		for (0 .. $size - 1) -> $j {
    			my $space = (@board[$k][$i][$j] == 1) ??
    			            '*' !! ' ';
    			$b ~= " $space |"
    		}
    		$b ~= "\n";
    	}
    	$b ~= '|' ~  '-' x (4 * $size - 1) ~ '|' ~ "\n\n";
    }

    # Return the board representation
    return $b;
}

# Copy board
sub copy-board(@src, @copy) {
    my $size = @src.elems;

    for (0 .. $size - 1) -> $i {
    	for (0 .. $size - 1) -> $j {
    		for (0 .. $size - 1) -> $k  {
    			@copy[$i][$j][$k] =
    				@src[$i][$j][$k];
    		}
    	}
    }
}
