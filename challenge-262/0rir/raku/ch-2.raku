#!/usr/bin/env rak;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ;
use v6;
use Test;

=begin comment

262-2: Count Equal Divisible
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints and an integer $k.

Write a script to return the number of pairs (i, j) where

a) 0 <= i < j < size of @int
b) ints[i] == ints[j
c) i x j is divisible by k
Example 1
Input: @ints = (3,1,2,2,2,1,3) and $k = 2
Output: 4

(0, 6) => ints[0] == ints[6] and 0 x 6 is divisible by 2
(2, 3) => ints[2] == ints[3] and 2 x 3 is divisible by 2
(2, 4) => ints[2] == ints[4] and 2 x 4 is divisible by 2
(3, 4) => ints[3] == ints[4] and 3 x 4 is divisible by 2
Example 2
Input: @ints = (1,2,3) and $k = 2
Output: 0
=end comment

my @Test =
    # $exp   @in                $k
    4,      (3,1,2,2,2,1,3),    2,
    0,      (1,2,3),            1,
    0,      (),                 1,
    0,      (1,),               0,
    3,      (0,0,0,),           1,
;
plan @Test ÷ 3;

multi func( Int $k, [] ) { 0 }
multi func( Int:D $k, @in) {
    # a) 0 <= i < j < size of @ints
    #b) ints[i] == ints[j]
    #c) i x j is divisible by k
    (^@in).combinations(2).grep( {
        ( .[0] < .[1] )
        and ( .[0] × .[1] %% $k )
        and ( @in[ $_[0]] == @in[ $_[1]] )
    }).Int;
}

for @Test -> $exp, @in, $k {
    is func($k, @in), $exp, "$exp <- $k «- @in.raku()";
}

done-testing;
my @in = ( 1,1,1,1,1,3,3,3);
my $j = 3;
say "Input: @ints = @in[] and \$k = $j\n Output: &func($j, @in)"


