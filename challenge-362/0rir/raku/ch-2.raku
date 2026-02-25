#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;
use Lingua::EN::Numbers;

=begin comment
May be edited for space.
362-2: Spellbound Sorting       Submitted by: Peter Campbell Smith
You are given an array of integers.
Write a script to return them in alphabetical order, in any language
of your choosing. Default language is English.
=end comment

my @Test =
(6, 7, 8, 9 ,10),       (8, 9, 7, 6, 10),
(-3, 0, 1000, 99),      (-3, 99, 1000, 0),
(1, 2, 3, 4, 5),        (5, 4, 1, 3, 2),
(0, -1, -2, -3, -4),    (-4, -1, -3, -2, 0),
(100, 101, 102),        (100, 101, 102),
;
plan +@Test ÷ 2;

#
constant English = \( 'negative','minus' );

sub task( @a -->List) {
    (@a.map: { $_.&cardinal.subst( |English ) => $_ };
    ).sort( { $^a.key cmp $^b.key })».value;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my @input  = 0, -1, -2, -3, -4;
say qq{\nInput:  (@input.join( ', '))\nOutput: (&task(@input).join( ', '))}
