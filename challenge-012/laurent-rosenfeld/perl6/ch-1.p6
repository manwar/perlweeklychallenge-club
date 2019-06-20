use v6;

my @primes = grep {.is-prime}, 1..*;
my @euclids = map {1 + [*] @primes[0..$_]}, 0..*;
say @euclids.first(not *.is-prime);
