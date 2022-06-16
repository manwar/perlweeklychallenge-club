my @small-primes = 2, 3, 5, 7, 11, 13, 17, 19, 23, 29;
my @result = (@small-primes[0..3] X* @small-primes[0..3]).sort.squish;
append @result, (@small-primes[4..9] X* @small-primes[4..9]).sort.squish;
say @result[0..19];
