#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT die 'Rakudo version is too old; need max with named args.'
     unless $*RAKU.compiler.version cmp v2023.07 == More;
use Test;

=begin comment
292-1: Twice Largest        Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.

Example 1
Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.
Example 2
Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.

=end comment

my @Test =
     (2, 4, 1, 0),  1,
     (1, 2, 3, 4),  Int,
     (),            Int,
     (1,),           Int,
;
plan @Test ÷ 2;

multi task( @a where +* < 2) { Int}
multi task( @a is copy -->Int) {
    my $max = @a.max: :kv;
    die 'Error: Input maximum is not unique.' if @$max ≠ 2;
    @a[$max[0]] :delete;
    $max[1] ≥ 2 × @a.max ?? $max[0] !! Int;
}

for @Test -> @in, $exp {
    is task(@in), $exp, ($exp // 'Int') ~ "  <- @in.raku()";
}
done-testing;

my @int = <9 62 16 5 47 1 70 40 10 53 3 73 165 56 74 57 23>».Int;
say "\nInput: @int = @int[]\n Output: ", task(@int) // -1;
