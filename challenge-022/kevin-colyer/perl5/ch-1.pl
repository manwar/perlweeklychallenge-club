#!/usr/bin/perl6
use v6;

use Test;

# 22.1 Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime numbers that differ from each other by 6. For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6. The term “sexy prime” is a pun stemming from the Latin word for six: sex.

my @p =  (2,3,*+2 ... ∞).grep: *.is-prime;


#| prints the num first sexy prime pairs
sub MAIN(Int :$pairs = 10)
{
    my Int $i=0;
    for ^$pairs -> $n {
        while  not (@p[$i]+6).is-prime {
            $i++; # skip one
        }
        say "{$n+1}th sexy prime pairs are: {@p[$i]} and {@p[$i]+6}";
        $i++; # chose next candidate...
    }
}
