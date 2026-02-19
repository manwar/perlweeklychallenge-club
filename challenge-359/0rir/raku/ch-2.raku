#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
359-2: String Reduction         Submitted by: Mohammad Sajid Anwar
You are given a word containing only alphabets,

Write a function that repeatedly removes adjacent duplicate characters from a string until no adjacent duplicates remain and return the final word.

=end comment

my @Test =
    # $in               $exp
    "aabbccdd",         "",
    "abccba",           "",
    "abcdef",           "abcdef",
    "aabbaeaccdd",      "aea",
    "mississippi",      "m",
;
plan +@Test ÷ 2;

sub task( Str:D(Any) $a is copy where { /^ <:L>* $/ } -->Str:D) {
    my $ret;
    repeat {
        $ret = $a;
        $a ~~ s:g/ (.)$0 //;
    } while $a ne $ret;
    $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;
=finish

my $word = "mississippi";
