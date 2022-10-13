#!/bin/env raku

unit sub MAIN(UInt:D \N = 1000);

my @cuban-primes = gather {
    for 1..* -> \n {
        my \m = 3*n² + 3*n + 1;
        last if m > N;

        take m if m.is-prime;
    }
};
put @cuban-primes.join(', ');
