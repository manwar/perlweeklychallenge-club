#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
242-2: Flip Matrix  Submitted by: Mohammad S Anwar
You are given n x n binary matrix.

Write a script to flip the given matrix as below.


1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1
Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
Example 2
Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
=end comment

my @Test =
    [[1, 1, 0], [1, 0, 1], [0, 0, 0]],
            [[1, 0, 0], [0, 1, 0], [1, 1, 1]],
    [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]],
            [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]],
;
plan @Test ÷ 2;

subset Matrix of Array;

sub reverse-n-not( @a is copy --> Matrix ) {
    @a.map( *.map( (!*).Int ).reverse.Array).Array
}

for @Test -> @in, @exp {
    is reverse-n-not(@in), @exp, "";
}
done-testing;

my @matrix = [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]];
say "\nInput @matrix = @matrix.raku()\nOutput: &reverse-n-not(@matrix).raku()";


exit;

