#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
May be edited for no good reason:
396-2: Trionic Array            Submitted by: Mohammad Sajid Anwar
You are given an array of integer.
Write a script to return true if the given array is Trionic otherwise return false.
An array is trionic if there exist indices 0 < p < q < n − 1 such that
arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing,
and arr[q…n − 1] is strictly increasing.
=end comment

my @Test =
    # in                        exp
    (1, 3, 5, 4, 2, 6, 8),      True,
    (1, 4, 4, 2, 1, 3, 5),      False,
    (2, 10, 3, 1, 9),           True,
    (1, 2, 3, 4, 3, 2, 1),      False,

    (1,2,3),            False,
    (1,2,3,1),          False,
    (1,2,3,1,2),        True,
    (1,2,1),            False,
    (1,2,1,2),          True,
    (),                 False,
;
plan @Test ÷ 2;

#multi task( @a where +* < 4) { False }
only task( @a -->Bool:D) {
    my @b = @a.rotor(  2 => -1);
    my $turn = 0;
    my $e;
                                sub want { $turn %% 2 ?? Less !! More; }
                                sub got  { $e.head <=> $e.tail }
    while $e = @b.shift  {
        for $_ = got() {
            if $_ == Same     { return False; }
            if $_ ≠ want()    { ++$turn; }
        }   
    }
    return $turn == 2;
}

for @Test -> @in,$exp, {
    is task( @in), $exp, "$exp <- @in.raku()";
}

done-testing;

my @arr = 1, 2, 3, 4, 3, 2, 1, 2,  3, 4, 6;

say qq{\nInput: @arr = @arr.raku()\nOutput: }, task( @arr);

