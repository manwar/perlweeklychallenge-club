#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
381-Task 1: Same Row Column         Submitted by: Mohammad Sajid Anwar
You are given a n x n matrix containing integers from 1 to n.

Write a script to find if every row and every column contains all the integers from 1 to n.

=end comment

my @Test =
    [[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3],],  True,
    [[1,],],                                    True,
    [[1, 2, 5], [5, 1, 2], [2, 5, 1],],         False,
    [[1, 2, 3], [1, 2, 3], [1, 2, 3],],         False,
    [[1, 2, 3], [3, 1, 2], [3, 2, 1],],         False,
;
plan +@Test ÷ 2;

sub task( @a -->Bool:D) {
    die 'Not matrix' unless @a[0].defined 
                        and @a == @a[0] == all @a[0..^@a];
    my @exp = 1…@a.elems;
    for ^@a -> \i {
        return False unless   @a[i].sort   ~~ @exp;
        return False unless (@a».[i]).sort ~~ @exp;
    }
    return True;
}

sub fmt(@a is copy -->Str) {
    my $prefix = 'Input: @matrix = [';
    my $indent =  ' ' x $prefix.chars;
    my @matrix = do for ^@a { '[' ~ @a[$_].join(', ') ~ "],\n"; }
    my Str $ret = ( $prefix ~ @matrix.join( $indent)).chomp;
    return $ret ~= "]\nOutput:";
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;

my @matrix = [[1, 2, 3, 4],
              [2, 3, 4, 1],
              [3, 4, 1, 2],
              [4, 1, 2, 3],];

say qq{\n&fmt(@matrix) &task(@matrix)};
