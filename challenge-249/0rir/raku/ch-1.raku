#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
249-1: Equal Pairs              Submitted by: Mohammad S Anwar
You are given an array of integers with even number of elements.
Write a script to divide the given array into equal pairs such that:
a) Each element belongs to exactly one pair.
b) The elements present in a pair are equal.

Example 1
Input: @ints = (3, 2, 3, 2, 2, 2)
Output: (2, 2), (3, 3), (2, 2)

Example 2
Input: @ints = (1, 2, 3, 4)
Output: ()
=end comment

my @Test =
    (3,2,3,2,2,2),  ((2,2), (3,3), (2,2)),
    (1,2,3,4),      (),
    (1,1,2,2,2,2,3,3,3,3,3,3,4,4),
                    ((1,1), (2,2), (2,2), (3,3),(3,3),(3,3),(4,4)),
;
my @Triplet =
    (3, 2, 3, 2, 2, 2), (),
    (3, 3, 3, 2, 2, 2), ((2, 2, 2), (3, 3, 3)),
    (1, 2, 3, 4), (),
    (1,1,1), (1,1,1),
;
plan @Test ÷ 2 + @Triplet ÷ 2;

sub equal-sets( $a is copy, Int $size = 2 -->List) {
    my $ret;
    $a.=BagHash;
    for @$a -> $p {
        return () unless (my $set-ct = $p.value ÷ $size) == $set-ct.floor;
        $ret.append: ($p.key xx $size) xx $set-ct;
    }
    $ret.List;
}

for @Test -> $in, $exp {
    is equal-sets($in).sort( *[0]), $exp.sort( *[0]),
        "Sorted Pairs    $exp.sort().List.raku() < $in.raku()";
}
for @Triplet -> $in, $exp {
    is equal-sets($in,3).sort, $exp.sort,
        "Sorted Triplets $exp.sort().List.raku() < $in.raku()";
}
done-testing;

my  @int = (1,1,2,2,2,2,3,3,3,3,3,3,4,4);
say "\nInput: @int = (@int[])\nOutput: &equal-sets( @int)<>.raku()";

exit;

