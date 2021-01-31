#!/usr/bin/env raku

sub binary-substring ($b, :$n=3) {
    $b
    andthen .comb($n)
    andthen .map: *.comb
    andthen [Z,] $_
    andthen .map: *.Bag
    andthen .map: { .{"0"} min .{"1"} }\
    andthen .sum
}

multi MAIN (Bool :$test!) {
    use Test;
    is binary-substring('100010001'),   3;
    is binary-substring('101100101'),   1;
    is binary-substring('10110111'):4n, 2;
    done-testing;
}

multi MAIN ($b, :$n=3) {
    say binary-substring $b, :$n
}
