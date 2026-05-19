#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
374-2 Largest Same-digits Number        Submitted by: Mohammad Sajid Anwar
You are given a string containing 0-9 digits only.
Write a script to return the largest number with all digits
the same in the given string.
=end comment

my @Test =
    # in                exp
    "6777133339",     3333,
    "1200034",           4,
    "44221155",         55,
    "88888",         88888,
    "11122233",        222,
;

plan +@Test ÷ 2;

sub task( Str:D() $a where so * ~~ /<[0..9]>+ / -->Int:D) {
    $a.comb.BagHash.pairs>>.&{ (.key x .value).Int }.max
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;


my $str = "969797713933111111111999139";

say qq{\nInput: \$str = $str\nOutput: }, task $str;

