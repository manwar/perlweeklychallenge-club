#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
310-2 Sort Odd Even         Submitted by: Mohammad Sajid Anwar

You are given an array of integers.
Write a script to sort odd index elements in decreasing order and even index elements in increasing order in the given array.

Example 1
Input: @ints = (4, 1, 2, 3)
Output: (2, 3, 4, 1)

Even index elements: 4, 2 => 2, 4 (increasing order)
Odd index elements : 1, 3 => 3, 1 (decreasing order)
Example 2
Input: @ints = (3, 1)
Output: (3, 1)
Example 3
Input: @ints = (5, 3, 2, 1, 4)
Output: (2, 3, 4, 1, 5)

Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
Odd index elements : 3, 1 => 3, 1 (decreasing order)
=end comment

my @Test =
    # in                exp
    (4,1,2,3),          (2,3,4,1),
    (3,1),              (3,1),
    (5,3,2,1,4),        (2,3,4,1,5),
    (),                 (),
    (5,),               (5,),
    (0,1,2),            (0,1,2),
    (0,1,2,3),          (0,3,2,1),
    (0,1,2,3,4),        (0,3,2,1,4),
;
plan @Test ÷ 2;

multi task( @a where +* ≤ 2 ) { @a }
multi task( @a --> Array) {
    my \end := @a.end;
    my ($e-end, $o-end)  = end %% 2 ?? (end, end -1) !! (end-1, end);
    @ = flat roundrobin ( @ = @a[0, *+2 … $e-end].sort),
                        ( @ = @a[1, *+2 … $o-end].sort.reverse);
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp // @exp.^name()} <- @in.raku()"
}

done-testing;

my @int = 0,1,2,3,4;
say "\nInput: @int = @int[]\nOutput: {task(@int)}";
