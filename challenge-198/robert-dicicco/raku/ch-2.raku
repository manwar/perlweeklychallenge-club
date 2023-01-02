#!/usr/bin/env raku

#`{

AUTHOR: Robert DiCicco

DATE  : 2023-01-02

Challenge 198 Prime Count ( Raku )

}

 

my @arr = [10,15,1,25];

 

for (@arr) -> $n {

                my $cnt = 0;

                print "Input: \$n = $n\n"; # find primes less than @arr[$n]

                for (0 .. $n - 1) -> $x {

                                if $x.is-prime {

                                                $cnt++;

                                }

                }

                print "Output: $cnt\n\n";

}

#`{

raku .\PrimeCount.rk

Input: $n = 10

Output: 4

 

Input: $n = 15

Output: 6

 

Input: $n = 1

Output: 0

 

Input: $n = 25

Output: 9

}
