#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
Task 1: Missing Integers
Submitted by: Mohammad Sajid Anwar
You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given array.


Example 1
Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

The given array has 6 elements.
So we are looking for integers in the range 1..6 in the given array.
The missing integers: (4, 6)

Example 2
Input: @ints = (1, 1, 1)
Output: (2, 3)

Example 3
Input: @ints = (2, 2, 1)
Output: (3)
=end comment

my @Test =
    [1, 2, 1, 3, 2, 5],     (4, 6),
    [1, 1, 1],              (2, 3),
    [2, 2, 1],              (3,),
    [-1, 0, 100],           (1,2,3),
    [-1, 0, 100, 1],        (2,3,4),
    [5,],                   (1,),
;
my @Die = [], ();

plan +@Die +@Test ÷ 2;

# returns an unordered Seq
sub task(  @a where *.elems > 0 --> Seq ) { ( (1...+@a) ∖ @a ).keys }

for @Test -> @in, @exp {
    is task( @in).sort, @exp, "{@exp // @exp.^name()} <- @in.raku()";
}
for @Die -> @in {
    dies-ok { task @in }, 'Deader';
}
done-testing;

my @int = 1, 2, 1, 3, 2, 5;

say qq{\nInput: @int = @int.raku()\nOutput: }, task @int;
