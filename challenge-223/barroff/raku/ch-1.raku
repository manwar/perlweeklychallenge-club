#!/usr/bin/env raku

use v6.d;

sub count-primes(UInt:D $number --> Int) {
    grep( &is-prime, 1..$number).elems;
}

sub sieve-of-eratosthenes(UInt:D $number --> Int) {
    if $number < 2 {
        return 0
    } else {
        my @primes = [2];
        APPLICATIONS: for (2..$number) -> $applicant {
            for @primes {
                next APPLICATIONS if $applicant % $_ == 0;
            }
            @primes.append($applicant);
        }
        return @primes.elems;
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 6;

    is count-primes(10), 4, 'works for 10';
    is count-primes(1),  0, 'works for 1';
    is count-primes(20), 8, 'works for 20';

    is sieve-of-eratosthenes(10), 4, 'works for 10';
    is sieve-of-eratosthenes(1),  0, 'works for 1';
    is sieve-of-eratosthenes(20), 8, 'works for 20';
}

#| Take user provided list like 1 17 8
multi sub MAIN(UInt $number) {
    say count-primes($number);
}
