#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
349-1: Power String         Submitted by: Mohammad Sajid Anwar
You are given a string.  Write a script to return the power of the given
string.
The power of the string is the maximum length of a non-empty substring
that contains only one unique character.
=end comment

my @Test =
    "textbook",             2,
    "aaaaa",                5,
    "hoorayyy",             3,
    "x",                    1,
    "aabcccddeeffffghijjk", 4,
    "b22",                  2,
    "22b",                  2,
    "",                     0,
    Str,                    Int,
;
plan +@Test ÷ 2;

multi task( Str:U $a) { Int }
multi task( Str:D $a where * eq '' ) {0}
multi task( Str:D $a) {
    my $candi = $a ~~ / ( (.){}  $0**0..* )  */;
    max $0.list».chars;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "textbook";
say qq{\nInput: \$str = "$str"\nOutput: },task $str;
