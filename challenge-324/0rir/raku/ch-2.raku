#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴

use v6.e.PREVIEW;  # for .are
use Test;

=begin comment
324-2: Total XOR            Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.

Example 1
Input: @ints = (1, 3)
Output: 6

Subset [1],    total XOR = 1
Subset [3],    total XOR = 3
Subset [1, 3], total XOR => 1 XOR 3 => 2

Sum of total XOR => 1 + 3 + 2 => 6

Example 2
Input: @ints = (5, 1, 6)
Output: 28

Subset [5],       total XOR = 5
Subset [1],       total XOR = 1
Subset [6],       total XOR = 6
Subset [5, 1],    total XOR => 5 XOR 1 => 4
Subset [5, 6],    total XOR => 5 XOR 6 => 3
Subset [1, 6],    total XOR => 1 XOR 6 => 7
Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3
Input: @ints = (3, 4, 5, 6, 7, 8)
Output: 480
=end comment

my @Test =
    # @in               $exp
    (1, 3),               6,
    (5, 1, 6),           28,
    (3, 4, 5, 6, 7, 8), 480,
    (-1, -3) ,           -2,
    (),                   0,
;

plan +@Test ÷ 2;

sub task( @a where { **.are(Int) or ** ~~ Empty } -->Int:D) {
sum do for @a.combinations  { [+^] $_ }
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;
my @int = 7, 11, 31;

say "\nInput: @int = @int.raku()\nOutput: {task @int}";
