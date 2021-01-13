# Test: perl6 ch-1.p6
our %found;

multi MAIN { MAIN(9) };
multi MAIN(Int $N) {
	say min-primes($N);
}

# Even primes will always have min 2 primes
# Odds will have min 2 or 3
# AKA goldbach conjecture
sub min-primes(Int $n) {

	if ($n.is-prime) {
		return "$n is already prime";
	}

	if ($n % 2 == 0) {
		my $i = 2;

		loop (my $j = $n - $i; $j > 2; $j--) {
			if ($i.is-prime && $j.is-prime) {
				return "$i + $j = $n";
			}
			$i++;
		}
	} else {
		my $i = 2;
		my $possible;

		loop (my $k = 0; $k < $n - $i; $k++ ) {
			next if ( $k != 0 &&
			         ($k == 1 || !$k.is-prime) );

			loop (my $j = $n - $i - $k; $j > 2; $j--) {
				if ( $k == 0
				  && $i.is-prime
				  && $j.is-prime ) {
					return "$i + $j = $n";
				}

				if ( $k > 0
				  && $k.is-prime
					&& $i.is-prime && $j.is-prime ) {
					$possible =  "$k + $i + $j = $n";
				}
				$i++;
			}

			$i = 2;
		}

		return $possible;
	}
}
