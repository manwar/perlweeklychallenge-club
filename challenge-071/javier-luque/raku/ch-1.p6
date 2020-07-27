# Test: perl6 ch-1.p6
multi MAIN { MAIN(10) };
multi MAIN(Int $N where $N > 1) {
	# Store answers
	my @values;
	my @peaks;

	# Populate @values
	for (0 .. $N - 1) -> $i {
		@values.push(50.rand.Int);

		# Check left most peak
		@peaks.push(@values[$i - 1])
			if ( $i == 1 &&
			     @values[$i - 1] >  @values[$i] );

		# Check middle peaks
		@peaks.push(@values[$i - 1])
			if ( $i > 1 &&
			     @values[$i - 1] >  @values[$i] &&
			     @values[$i - 1] >  @values[$i - 2]);

		# Check last peaks
		@peaks.push(@values[$i - 1])
			if ( $i == $N - 1 &&
		       @values[$i] > @values[$i - 1]);
	}

	# Output values
	say 'Array: ' ~ @values.perl;
	say 'Peak:  ' ~ @peaks.perl;
}
