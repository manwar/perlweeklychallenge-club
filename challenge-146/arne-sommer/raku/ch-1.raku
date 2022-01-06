#! /usr/bin/env raku

unit sub MAIN (Int :$number where $number > 0 = 10001);

my $primes := (1..Inf).grep( *.is-prime );

say $primes[$number -1];