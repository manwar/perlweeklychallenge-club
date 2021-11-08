#!/usr/bin/env raku

use Test;
plan 3;

for 16 => 4, 9 => 2, 15 => 2
{
    is fibonacci-sums(.key), .value, "Example " ~ ++$ 
}

sub fibonacci-sums($n)
{
    my $fib := 1, 2, { $^a + $^b } ... { $^a + $^b >= $n }
   
    + $fib.combinations(2..*).grep(*.sum == $n)
}
