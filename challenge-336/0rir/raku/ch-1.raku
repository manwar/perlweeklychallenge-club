#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
336-1: Equal Group          Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return true if the given array can be divided into one or more groups: each group must be of the same size as the others, with at least two members, and with all members having the same value.


Example 1
Input: @ints = (1,1,2,2,2,2)
Output: true

Groups: (1,1), (2,2), (2,2)

Example 2
Input: @ints = (1,1,1,2,2,2,3,3)
Output: false

Groups: (1,1,1), (2,2,2), (3,3)

Example 3
Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
Output: true

Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)

Example 4
Input: @ints = (1,2,3,4)
Output: false

Example 5
Input: @ints = (8,8,9,9,10,10,11,11)
Output: true

Groups: (8,8), (9,9), (10,10), (11,11)

=end comment

my @Test =
    (1,1,2,2,2,2),              True,
    (1,1,1,2,2,2,3,3),          False,
    (5,5,5,5,5,5,7,7,7,7,7,7),  True,
    (1,2,3,4),                  False,
    (8,8,9,9,10,10,11,11),      True,

    (1,1,2,2),                  True,
    (1,1,1),                    True,
    (1,1),                      True,
    (1,),                       False,
    (),                         False,
;
plan +@Test ÷ 2;

multi task( @a where (@a ~~ Empty or @a == 1) ) { False }
multi task( @a -->Bool:D) {
    my BagHash[Int] $bh;
    ++$bh{$_} for @a;
    (my $m = $bh.values.min) > 1 and so $bh.values.all %% $m;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;
my @int = 8,8,9,9,10,10,11,11 ;
say "\nInput: @int = ({@int.join( ', ')})\nOutput: &task( @int)"

