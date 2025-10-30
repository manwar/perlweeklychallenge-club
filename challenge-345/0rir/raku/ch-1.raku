#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
345-Task 1: Peak Positions
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly greater than its left and right neighbours. Return the indices of all such peak positions.
=end comment

my @Test =

    #  in                           exp
    (1, 3, 2),                      (1,),
    (2, 4, 6, 5, 3),                (2,),
    (1, 2, 3, 2, 4, 1),             (2, 4),
    (5, 3, 1),                      (0,),
    (1, 5, 1, 5, 1, 5, 1),          (1, 3, 5),

    (5, 1, 5, 1, 5, 1, 5),          (0, 2, 4, 6),
    (1, 1),                         (),
    (1, 0),                         (0,),
    (0, 1),                         (1,),
    (3, 1, 2),                      (0, 2),
    (1, 1, 2),                      (2,),
    (3, 1, 1),                      (0,),
    (1, 1, 1),                      (),
    (1, 1, 1, 1),                   (),
    (1, 1, 1, 1, 1),                (),
    (1, 1, 1, 1, 1, 1),             (),
    (1, 1, 1, 1, 1, 1, 1),          (),
    ( 1 xx 500 ),                   (),
    ( (1,0) xx 500).flat,           ( 0,2,4 … 998),
    ( (0,1) xx 50_000).flat,          ( 1,3,5 … 99_999),
;
plan +@Test ÷ 2;

multi task( @a -->Array) {
    my @ret;

    @ret.unshift(   0)  if @a[0]   > @a[  1];

    my @trio = @a.rotor( 3 => -2);
    my $idx = 0;  
    for @trio -> @t {
        ++$idx;
        if @t[0] < @t[1] > @t[2] {
            @ret.push: $idx;
        }
    }
    @ret.push( @a.end)  if @a[*-1] > @a[*-2];
    return @ret;
}

for @Test -> @in, @exp {
    if @in < 20 { 
        is task( @in), @exp, "@exp.raku() <- @in.raku()";
    } else {
        is task( @in), @exp,
            "@exp.raku.substr(0,20) … "
          ~ "<- @in.raku.substr(0,20) … @in.elems() elems";
    }
}
done-testing;

my @int = (1, 5, 1, 5, 1, 5, 1);
say "\nInput: @int = (", @int.join( ', '), ")",
    "\nOutput: ( ", task(@int).join(', '), ")";

=finish
