#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $count? where * > 0 = 10) {
    my @primes = (^∞).grep( *.is-prime );
    
    my @sexy = lazy gather {
        for ^∞ -> $i {
            take @primes[$i] => @primes[$i] + 6 if (@primes[$i]+6).is-prime;
        };
    }

    say "Primes:";
    say "{$_.key} {$_.value}" for @sexy[^$count];
}


