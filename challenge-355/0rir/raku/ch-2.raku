#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited.
355-2: Mountain Array       Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.
Write a script to return true if the given array is a valid mountain array.

An array is mountain if and only if:
1) arr.length >= 3
and
2) There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

=end comment

my @Test =
    (1, 2, 3, 4, 5),        False,
    (0, 2, 4, 6, 4, 2, 0),  True,
    (5, 4, 3, 2, 1),        False,
    (1, 3, 5, 5, 4, 2),     False,
    (1, 3, 2),              True,
;
plan +@Test ÷ 2;

sub task( @a where +* ≥ 3 -->Bool) {
    my \mx := @a.max(:k);

    return False if     mx.elems > 1
                    or  mx[0]    ≤ 0
                    or  @a.end   ≤ mx[0];

    for ^mx[0] -> \i {
        return False unless @a[i] < @a[i+1]
    }

    for mx[0]..^(@a-1) -> \i {
        return False unless @a[i] > @a[i+1]
    }

    True;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}

done-testing;


my @int =  0, 2, 4, 6, 4, 2, 0;

say qq{\nInput: @int = @int.raku()\nOutput: }, task @int;

