# Test: perl6 ch-1.p6
multi MAIN { MAIN(20) };
multi MAIN(Int $N where $N > 10) {
	my ($factorial, $zeros) = processN($N);
	say "$zeros as $N! = $factorial has $zeros trailing zeroes";
}

sub processN(Int $N) {
	my $factorial = 1;
	my $zeroes = 0;

	# Calculate factorial
	loop (my $i = 2; $i <= $N; $i++) {
		$factorial *= $i;
	}

	# Find zeroes
	loop ($i = 5; Int($N / $i) >= 1; $i *= 5) {
		$zeroes += Int($N / $i);
	}

	return $factorial, $zeroes;
}
