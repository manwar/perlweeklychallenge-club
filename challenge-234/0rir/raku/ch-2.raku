#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
234-2: Unequal Triplets     Submitted by: Mohammad S Anwar
You are given an array of positive integers.

Write a script to find the number of triplets (i, j, k) that satisfies num[i] != num[j], num[j] != num[k] and num[k] != num[i].

Example 1
Input: @ints = (4, 4, 2, 4, 3)
Ouput: 3

(0, 2, 4) because 4 != 2 != 3
(1, 2, 4) because 4 != 2 != 3
(2, 3, 4) because 2 != 4 != 3
Example 2
Input: @ints = (1, 1, 1, 1, 1)
Ouput: 0
Example 3
Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 28

triplets of 1, 4, 7  = 3x2×2 = 12 combinations
triplets of 1, 4, 10 = 3×2×1 = 6  combinations
triplets of 4, 7, 10 = 2×2×1 = 4  combinations
triplets of 1, 7, 10 = 3x2x1 = 6 combinations
=end comment

my @Test =
    3,  (4, 4, 2, 4, 3),
    0,  (1, 1, 1, 1, 1),
    28, (4, 7, 1, 10, 7, 4, 1, 1),
;

plan @Test/2;

sub func( @a = @Test[1]) {
    my @c = @a.combinations(3).grep( {
            $_[0] ≠  $_[1]
        and $_[1] ≠  $_[2]
        and $_[2] ≠  $_[0] }
    ).elems;
}

for @Test -> $exp, @in {
    is func(@in), $exp, "$exp <- @in.raku()";
}
done-testing;
exit;

