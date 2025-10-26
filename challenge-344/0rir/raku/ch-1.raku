#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
344-Task 1: Array Form Compute      Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

The array form of an integer is a digit-by-digit representation stored as an array, where the most significant digit is at the 0th index.
=end comment

my @Test =
    # @in                   $i      @exp
    [1, 2, 3, 4],           12,     (1, 2, 4, 6),
    [2, 7, 4],              181,    (4, 5, 5),
    [9, 9, 9],              1,      (1, 0, 0, 0),
    [1, 0, 0, 0, 0],        9999,   (1, 9, 9, 9, 9),
    [0,],                   1000,   (1, 0, 0, 0),

    [9, 9, 9],              9999,   (1, 0, 9, 9, 8)
;
plan +@Test ÷ 3;

# Treat @l (of digits) as an integer to add the digits of $b to it.
only task( @l where * ⊆ ^10, Any(Int) $b) {
    my @ret;
    my @r = $b.comb».Int;

    my ($lr, $l, $r, $carry) = 0 xx 4;;
    while @r or @l {
        $l = @l ?? @l.pop !! 0;
        $r = @r ?? @r.pop !! 0;
        $lr =  $r + $l + $carry;
        $carry = $lr div 10;
        $lr %= 10;
        @ret.unshift: $lr;
    }
    @ret.unshift( $carry) if $carry;
    @ret;
}

for @Test -> @in, $i, @exp {
    is task( @in, $i, ), @exp, "{@exp // @exp.^name()} <- @in.raku() ∘∘ $i";
}
done-testing;

my @int = [9, 9, 9];
my $x = 99999;

say "\nInput: @int = @int.raku(), \$x = $x\nOutput: ", task @int, $x;

