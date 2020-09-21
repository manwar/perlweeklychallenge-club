#!/bin/env raku

my Int @primes = (2..∞).grep: *.is-prime;

sub sum-of-primes(Int:D $N, Int:D $pi, Int:D $cnt --> Num) {
    when $N < @primes[$pi]  { Inf }
    when $N.is-prime        { (1 + $cnt).Num }
    min(sum-of-primes($N - @primes[$pi], $pi, $cnt + 1),
        sum-of-primes($N, $pi + 1, $cnt)
    );
}

say "$_:\t{sum-of-primes($_, 0, 0)}" for 2..30;
