#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment

223-1: Count Primes         Submitted by: Mohammad S Anwar
You are given a positive integer, $n, find the total count of primes less
than or equal to the given integer.

Example 1
Input: $n = 10
Output: 4

Since there are 4 primes (2,3,5,7) less than or equal to 10.
Example 2
Input: $n = 1
Output: 0
Example 3
Input: $n = 20
Output: 8

Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.
=end comment

my @Test =
    1,         0,
    2,         1,
    3,         2,
    4,         2,
    5,         3,
    6,         3,
    7,         4,
    8,         4,
    9,         4,
    10,        4,
    20,        8,
    113,      30,       
    225,      48, 
    271,      58,
    684,     124,
    499,      95,
    502,      95,
    503,      96,
    504,      96,
;
plan @Test ÷ 2;

constant @prime = lazy (2,3,*+2 ... ∞).grep: *.is-prime;

sub count-of-primes-lte( $n --> Int) { @prime.first( * > $n, :k); }

for @Test -> $in, $exp {
    is count-of-primes-lte( $in), $exp, "$exp primes ≤ $in";
}
done-testing;

my $n = 499;
say "\nInput: \$n = $n\nOutput: ", count-of-primes-lte( $n);

exit;

