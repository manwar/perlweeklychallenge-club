#!/usr/bin/env raku
=begin comment
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-26
Challenge 223 Task 1 Count Primes ( Raku )
-----------------------------------------
=end comment
use v6;

my @input_n = (10,1,20);

for (@input_n) -> $n {
     say "Input: \$n = $n";
    my $num = 0;
    my $cnt = 0;
    while $num < $n {
        $cnt++ if $num.is-prime;
        $num++;
    }
    say "$cnt\n";
}

=begin comment
-----------------------------------------
SAMPLE OUTPUT
raku .\CountPrimes.rk
Input: $n = 10
4

Input: $n = 1
0

Input: $n = 20
8
-----------------------------------------
=end comment


