#!/usr/bin/env perl6

use v6;

#| Usage notes
multi sub MAIN ( :h(:$help) ) { say $*USAGE }

#| Calculate the first n paris of "sexy" primes (being two primes seperated by 6)
multi sub MAIN (
    UInt $n = 10 #= Number to calculate
) {
    .say for (^Inf).hyper.grep( { $_.is-prime && ($_ + 6).is-prime } ).map( { ($_,$_+6).join(",") } )[^$n]; 
}
