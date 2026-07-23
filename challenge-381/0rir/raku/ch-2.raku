#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
381-2 Task 2: Smaller Greater Element   Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to find the number of elements that have both a strictly smaller and greater element in the given array.

=end comment

my @Test =
    (2,4),                  0,
    (1, 1, 1, 1),           0,
    (1, 1, 4, 8, 12, 12),   2,
    (3, 6, 6, 9),           2,
    (0,),                   0,
    (),                     0;
;
plan +@Test ÷ 2;

sub task( @a --> Int) {
    my $mn = min @a;
    my $mx = max @a;
    return + @a.grep: $mn < * < $mx ;
}

sub task-k( @a --> Int) {
    # one elem  or     general case
    0           max    @a - ( min(:k, @a), max( :k, @a) ).flat;
}

for @Test -> $in, $exp {
    is task( $in),   $exp, "{$exp // $exp.^name()} <- $in.raku()";
    is task-k( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @int = 3, 6, 6, 9;

say qq{\nInput: @int = (@int[])\nOutput: &task(@int) }

