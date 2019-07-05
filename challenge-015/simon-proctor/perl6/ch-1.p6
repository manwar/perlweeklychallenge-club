#!/usr/bin/env perl6
use v6;

#| Print the first x strong and weak primes 
sub MAIN( 
    UInt $x #= Number of primes to print
) {
    my @primes = (1..*).grep( *.is-prime );

    my @strong = (1..*).grep( { @primes[$_] > (@primes[$_-1] + @primes[$_+1]) / 2 } ).map( { @primes[$_] } );
    my @weak = (1..*).grep( { @primes[$_] < ( @primes[$_-1] + @primes[$_+1] ) / 2 } ).map( { @primes[$_] } );

    say "Strong {@strong[^$x].join(", ")}";
    say "Weak {@weak[^$x].join(", ")}"; 
}