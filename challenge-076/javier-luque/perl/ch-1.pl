#!/usr/bin/perl
# Test: ./ch-1.pl
use Modern::Perl;
use Math::Prime::Util qw /factor is_prime/;

my $N = shift // 9;
say min_primes($N);

# Even primes will always have min 2 primes
# Odds will have min 2 or 3
# AKA goldbach conjecture
sub min_primes {
	my $n = shift;

	if (is_prime($n)) {
		return "$n is already prime";
	}

	if ($n % 2 == 0) {
		my $i = 2;

		for (my $j = $n - $i; $j > 2; $j--) {
			if (is_prime($i) && is_prime($j)) {
				return "$i + $j = $n"
			}
			$i++;
		}
	} else {
		my $i = 2;
		my $possible;

		for (my $k = 0; $k < $n - $i; $k++ ) {
			next if ( $k != 0
			     && ( $k == 1 || !is_prime($k)) );

			for (my $j = $n - $i - $k; $j > 2; $j--) {

				if ( $k == 0 && is_prime($i)
				  && is_prime($j) ) {
					return "$i + $j = $n";
				}

				if ( $k > 0 && is_prime($k)
				  && is_prime($i)
					&& is_prime($j) ) {
					$possible =  "$k + $i + $j = $n";
				}
				$i++;
			}

			$i = 2;
		}

		return $possible;
	}
}
