#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
297-2: Semi-Ordered Permutation
Submitted by: Mohammad Sajid Anwar
You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a semi-ordered permutation.

A permutation is a sequence of integers from 1 to n of length n containing  each number exactly once.
A permutation is called semi-ordered if the first number is 1 and the last number equals n.
You are ONLY allowed to pick adjacent elements and swap them.

Example 1
Input: @ints = (2, 1, 4, 3)
Output: 2

Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)
Example 2
Input: @ints = (2, 4, 1, 3)
Output: 3

Swap 4 <=> 1 => (2, 1, 4, 3)
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)
Example 3
Input: @ints = (1, 3, 2, 4, 5)
Output: 0

Already a semi-ordered permutation.

=end comment

my @Test =
    (1,),              0,
    (1, 2),            0,
    (3, 2, 1,),        3,
    (2, 1, 4, 3),      2,
    (2, 4, 1, 3),      3,
    (1, 3, 2, 4, 5),   0,
;
my @Dust = (), @[], (1,3), (2,3);

plan @Dust + @Test ÷ 2;

multi task( @a where * ~~ Empty  )  { die 'got Empty array'  }
multi task( @a where *.elems == 1) { 0} 
multi task( @a where { .[0] == 1 and .[*-1] == .elems } -->Int) { 0 }
multi task( @a -->Int) {
    my $head-loc = @a.first( 1, :k)         // die 'no head';
    my $tail-loc = @a.first( @a.elems, :k)  // die 'no tail'; 
    $head-loc + @a.end - $tail-loc + ( $head-loc < $tail-loc ?? 0 !! -1)
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in.raku()";
}

for @Dust -> @in {
    dies-ok { task(@in)}, "dies-ok @in.raku()";
}

done-testing;

my $elems = (^7).pick;
my @int = ( 1...$elems + 5).pick($elems + 5);
say "\nInput: @int = @int[]\nOutput: {task @int}";

