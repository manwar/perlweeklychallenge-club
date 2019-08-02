#!/usr/bin/env perl6

# Mersenne prime generator.
my \M := (^∞)
           .grep(*.is-prime)
           .map(-> $n { 2 ** $n - 1})
           .grep(*.is-prime);

# Derive perfect number from Mersenne primes.
my \P := M.map: -> $q { $q * ($q + 1) div 2 };

# Compute and present the first 5, one per line.
P[^5]».put
