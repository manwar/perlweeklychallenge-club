#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for brevity, clarity or no good reason.
391-1: Array Median        Submitted by: Mohammad Sajid Anwar

You are given two sorted arrays.
Write a script to merge the two given sorted arrays and return
the median of the merged array.
=end comment

my @Test =
    (2,),            (4,),               3.0,
    (1,2,3),        (7,8,9,10),          7.0,
    (),             (10,20,30,40),      25.0,
    (100,),         (1,2,3,4,5,6,7),     4.5,
    (1,2,2),        (2,2,3),             2.0,
    [],             [],                  Rat,
;
plan +@Test ÷ 3;

multi task( [], [] ) { Rat }
multi task( @a, @b  -->Rational:D) {
    my @ary = sort flat @a, @b;
    my $center = @ary.end ÷ 2;

    Rat( $center == $center.Int
                ?? @ary[$center.Int]
                !! @ary[ $center.floor, $center.ceiling].sum ÷ 2
   );
}

for @Test -> $l, $r, $exp {
    is task( $l, $r), $exp,
            "{$exp // $exp.^name()} <- $l.raku() ∘∘ $r.raku()";
}
done-testing;

my @arr1 = 1,2,3,200,5,78,9;
my @arr2 = 7,8,9,10,234;

say qq{\nInput: @arr1 = @arr1.raku() @arr2 = @arr2.raku()\n}
    ~ "Output: ", task @arr1, @arr2;
