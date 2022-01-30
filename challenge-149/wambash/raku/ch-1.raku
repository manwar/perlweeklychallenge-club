#!/usr/bin/env raku

constant @fibonacci = 0,1, * + * ... *;

sub fibonacci-digit-sum ($n) {
    $n
    andthen .comb
    andthen .sum
    andthen { $_ == @fibonacci.first: * ≥ $_  }\
}

constant @fibonacci-digit-sum = ^Inf .grep: &fibonacci-digit-sum ;

multi MAIN (Bool :test($)!) {
    use Test;
    is fibonacci-digit-sum(23), True;
    is fibonacci-digit-sum(24), False;
    is fibonacci-digit-sum(99111), True;
    is @fibonacci-digit-sum.head(20) , [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44];
    done-testing;
}

multi MAIN ($n=20) {
    put @fibonacci-digit-sum.head: $n
}
