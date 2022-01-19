constant @primes = (2, 3, 5, 7 … *).grep(&is-prime);
say @primes.skip(10_000).head;
