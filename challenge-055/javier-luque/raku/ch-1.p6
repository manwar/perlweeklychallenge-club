# Test: perl6 ch-1.p6 2 3

multi MAIN(Int $b where * > 0) {
    my $n = ((log($b) / log(2)) + 1).Int;
    $n = 32 if ($n > 32);
    MAIN($b, $n);
}

multi MAIN(Int $a where * > 0 , Int $n where 0 < * < 32) {
    # Throw out bits outside of our range
    my $mask = (2 ** $n - 1);
    my $b = $a +& $mask;

    # Original binary
    say "ORIGINAL: " ~ sprintf("%0*b", $n, $b) ~ "\n";

    # Store the solution;
    my %solutions;
    my $longest_solution = 0;

    # flip algorithm
    for (0 .. $n -1) -> $l {
        for ($l .. $n - 1) -> $r {
        	# Flip Mask
        	my $flip_mask = 0;
        	for ($l .. $r) -> $i {
        		$flip_mask += (2 ** ($n - $i - 1) );
        	}

        	# Calculate the keep mask
        	my $keep_mask = (+^ $flip_mask) +& $mask;

        	# Flip the relevant bits and calculate kept bits
        	my $flipped_bits =  +^ ($b +& $flip_mask) +& $flip_mask;
        	my $kept_bits    = $b +& $keep_mask;

        	# Add the bits outside the flipped bit
        	my $flipped_number = $flipped_bits + $kept_bits;

        	# Now store the number of ones
        	my $length = calculate-true-bits($flipped_number);

        	# Store the solutions
        	%solutions{$length} = []
        		unless (%solutions{$length});

        	my %solution = 	(
        		L      => $l,
        		R      => $r,
        		number => $flipped_number
        	);

        	%solutions{$length}.push(%solution);

        	# Length of the longest solution
        	$longest_solution = $length
        		if ($longest_solution < $length);
        }
    }

    say "SOLUTIONS length($longest_solution):";
    for  (@(%solutions{$longest_solution})) -> $solution {
        say 'L: ' ~ $solution{'L'} ~
            ' R: ' ~ $solution{'R'} ~
            ' Number: ' ~
            sprintf("%0*b", $n, $solution{'number'});
    }
}

# Calculate the number of true bits
sub calculate-true-bits(Int $n is copy) {
    my $count = 0;

    repeat {
        $count++ if ($n +& 1);
    } while ($n = $n +> 1);

    return $count;
}

