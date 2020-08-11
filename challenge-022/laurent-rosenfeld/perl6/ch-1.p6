use v6;

my @sexy-primes = grep { .is-prime and ($_ + 6).is-prime}, (2, 3, *+2 ... Inf);
say "@sexy-primes[$_] ", @sexy-primes[$_] + 6 for ^10;
