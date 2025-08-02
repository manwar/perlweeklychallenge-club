#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
270-1: Special Positions       Submitted by: Mohammad Sajid Anwar

Given a m x n binary matrix, return the number of special positions.

A position (i, j) is called special if $matrix[i][j] == 1 and
all other elements in the row i and column j are 0.

Example 1
Input: $matrix = [ [1, 0, 0],
                   [0, 0, 1],
                   [1, 0, 0],
                 ]
Output: 1

There is only one special position (1, 2) as $matrix[1][2] == 1
and all other elements in row 1 and column 2 are 0.
Example 2
Input: $matrix = [ [1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1],
                 ]
Output: 3

Special positions are (0,0), (1, 1) and (2,2).
=end comment

my @Test =
    [ [1, 0, 0], [0, 0, 1], [1, 0, 0], ],  1,
    [ [1, 0, 0], [0, 1, 0], [0, 0, 1], ],  3,
    [ [1,],],                              1,
    [ [1,0],],                             1,
    [ [1,1],],                             0,
    [ [1,2],],                             0,
    [ [2,2],],                             0,
    [ [0,0,0,0,0], [0,0,0,0,0], [0,0,0,0,0], [0,0,0,0,0], [0,0,0,0,0], ],  0,
    [ [0,0,0,0,0], [0,0,0,0,0], [0,0,1,0,0], [0,0,0,0,0], [0,0,0,0,0], ],  1,
    [ [1,0,0,0,0], [0,1,0,0,0], [0,0,1,0,0], [0,0,0,1,0], [0,0,0,0,1], ],  5,
    [ [1,0,0,0,0], [0,1,0,0,2], [0,0,1,0,0], [0,0,0,1,0], [0,0,0,0,1], ],  3,
;
plan @Test ÷ 2;

multi task( @a where *.end  ==  0        -->Int) {
        ( 1 == @a[0].grep( 1)  and  @a[0].end  == @a[0].grep(0) // 0 )  ??   1 !! 0;
}
multi task( @a -->Int) {
    my $ret = 0;
    my $columns = @a[0].elems;
    for ^@a -> \i {          # one one                   balance zeds
        next unless  1 == @a[i].grep( 1)  and  $columns - 1  == @a[i].grep( 0);
        my $col = @a[i].first: 1, :k;
        my @col := do @a[$_][$col] for ^@a;
        next unless  1 == @col.grep( 1);
        next unless $columns - 1  == @col.grep( 0);
        $ret += 1;
    }
    $ret;
}

for @Test -> @in, $exp {
    is task(@in), $exp, "$exp <- @in.raku()";
}

done-testing;
