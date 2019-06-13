use v6;

my @primes = grep {.is-prime}, 1..*;
say (map {1 + [*] @primes[0..$_]}, 0..*).first(not *.is-prime);
