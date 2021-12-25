use v6;

constant \MAX = 100;
my @primes = grep { .is-prime }, 1..MAX/2;
my @nums = grep { $_ <= MAX }, map { [*] $_[0,1] },
    (@primes X @primes);
say @nums.sort.squish;
