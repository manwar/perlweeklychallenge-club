#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
293-1: Similar Dominos          Submitted by: Mohammad Sajid Anwar
You are given a list of dominos, @dominos.

Write a script to return the number of dominoes that are similar to any other domino.

$dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and b = d) or (a = d and b = c).

Example 1
Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Output: 2

Similar Dominos: $dominos[0], $dominos[1]
Example 2
Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Output: 3

Similar Dominos: $dominos[0], $dominos[1], $dominos[3]
=end comment


my @Test =
    (),                                         0,
    ([1, 3],),                                  0,
    ([1, 3],[1, 3]),                            2,
    ([1, 3],[1, 3],[3, 1]),                     3,
    ([1, 3], [3, 1], [2, 4], [6, 8]),           2,
    ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]),   3,
;

plan @Test ÷ 2;

# Flip dominos to ease matching. Create a sorted string representation.
sub mash(  @a ) { @a.sort( *.Int).join( '∘') }

sub task( @a -->Int) {
    sum (
        @a.map( *.&mash)
        .Bag.grep( *.value > 1)
    )».value
    // 0;
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in.raku()";
}

done-testing;

my @domino = [1,3], [3,1], [2,4], [1,1], [6,8], [2,4], [6,8], [4,2], [7,7];

say qq{\nInput: @dominos = @domino.raku()\nOutput: &task(@domino) };

