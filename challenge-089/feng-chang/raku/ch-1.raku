#!/bin/env raku

=begin Challenge

You are given a positive integer $N.

Write a script to sum GCD of all possible unique pairs between 1 and $N.

Example 1:

Input: 3
Output: 3

gcd(1,2) + gcd(1,3) + gcd(2,3)

Example 2:

Input: 4
Output: 7

gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4)

=end Challenge

sub MAIN(UInt:D $N) {
    (1..$N-1 X 2..$N).grep({.[1] > .[0]}).map({.[0] gcd .[1]}).sum.put;
}
