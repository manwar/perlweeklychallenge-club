#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
Edited for space.
339-2: Peak Point               Submitted by: Mohammad Sajid Anwar
You are given an array of altitude gain.
Write a script to find the peak point gained.
=end comment

my @Test =
    #   in                 max-elevation
    (-5, 1, 5, -9, 2),      1,
    (10, 10, 10, -25),     30,
    (3, -4, 2, 5, -6, 1),   6,
    (-1, -2, -3, -4),       0,
    (-10, 15, 5),          10,
    (),                     0,
;
plan +@Test ÷ 2;

sub task( @a is copy -->Int ) {
    @a.unshift(0);
    max do for ^@a { @a[0..$_].sum }
#   my $ret = 0;
#   for ^@a { $ret max= @a[0..$_].sum }
#   $ret;

}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;
