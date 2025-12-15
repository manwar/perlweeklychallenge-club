#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT die 'Need rakudo version 2023.08 or later for min and max.'
            unless $*RAKU.compiler.version cmp v2023.07 == More;
use Test;

=begin comment
May be edited for space.
251-1: Special Average          Submitted by: Mohammad Sajid Anwar
You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the given array.

=end comment

my @Test =
    # in
   (8000, 5000, 6000, 2000, 3000, 7000),     5250,
   (100_000, 80_000, 110_000, 90_000),     95_000,
   (2500, 2500, 2500, 2500),                    0,
   (2000,),                                     0,
   (1000, 2000, 3000, 4000, 5000, 6000),     3500,
   (8, 5, 6, 2, 3, 7),                          5.25,
    (2500, 2500, 2500, 2500),                   0,
   (100, -80, -110, 95),                        7.5,
    (-2,),                                      0,
    #(),                                      XXXspec?,
    #List,                                    XXXspec?,
;
plan +@Test ÷ 2;

multi task( @a where @a.max == @a.min --> 0) {}
multi task( @a -->Real) {
    my @mini = @a.min( :v);
    my @maxi = @a.max( :v);
    return 
           ( (sum @a) - (sum flat @maxi, @mini))
         ÷
           ( @a - @maxi - @mini)
         .narrow
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @int = 10, 8, 11, 9;
say qq{\nInput: @int = ( @int[])\nOutput: }, task @int;
