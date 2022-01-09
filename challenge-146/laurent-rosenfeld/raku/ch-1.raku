use v6;

my @primes = grep { .is-prime }, (1, 2, 3, -> $a { $a + 2} ...Inf);
say @primes[10001 - 1];  # Subtract 1 because the array starts at 0
