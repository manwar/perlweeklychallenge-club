#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT die 'Need rakudo version 2022.02 or later for min and max.'
            unless $*RAKU.compiler.version cmp v2022.01 == More;
use Test;

=begin comment
May be edited for space.
351-2: Arithmetic Progression       Submitted by: Mohammad Sajid Anwar
You are given an array of numbers.

Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false.

A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.

=end comment

my @Test =
    # in                    exp
    (1, 3, 5, 7, 9),        True,
    (9, 1, 7, 5, 3),        True,
    (1, 2, 4, 8, 16),       False,
    (5, -1, 3, 1, -3),      True,
    (1.5, 3, 0, 4.5, 6),    True,
    (1.1,1.3, 1.5, 1.7, 1.9),        True,
    (1.1,1.300000001, 1.5, 1.7, 1.9), False,
    (1,),                   False,
;
plan +@Test ÷ 2;

multi task( @a where *.end == 0) { False}
multi task( @a is copy --> Bool) {
    die 'not all real numbers' unless @a.are: Real;
    @a = map { .[0] - .[1] },  @a.sort.rotor( 2 => -1);
    return True if @a[0] == all @a;
    False
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @num = 1.5, 3, 0, 4.5, 6;

say qq{\nInput: @num = (@num[])\nOutput: }, task @num;
=finish
