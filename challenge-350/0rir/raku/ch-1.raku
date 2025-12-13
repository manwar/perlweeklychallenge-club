#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
350-1: Good Substrings      Submitted by: Mohammad Sajid Anwar
You are given a string.

Write a script to return the number of good substrings of length three in the given string.

A string is good if there are no repeated characters.
=end comment

my @Test =
    # in            exp
    "abcaefg",      5,
    "xyzzabc",      3,
    "aababc",       1,
    "qwerty",       4,
    "zzzaaa",       0,
    "12",           0,
    "1",            0,
    "",             0,
    Str,            Int,
;
plan +@Test ÷ 2;

constant GOOD-SIZE = 3; # Size of substrings to check.

multi task( Str:U $a ) { Int }
multi task( Str:D $a where *.chars < GOOD-SIZE ) { 0 }
multi task( Str:D $a -->Int) {
    my Int $ret = 0;
    for 0..($a.chars - GOOD-SIZE) -> \i {
        my $candi = $a.substr( i, GOOD-SIZE);

            # XXX Code cursed with fragility by the threeness of GOOD-SIZE.
        ++$ret unless   $candi.substr( 0, 1) eq $candi.substr( 1, 1) 
                    or  $candi.substr( 0, 1) eq $candi.substr( 2, 1) 
                    or  $candi.substr( 1, 1) eq $candi.substr( 2, 1);
    }
    $ret
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "abcaefg";

say qq{\nInput: \$str = "$str"\nOutput: }, task $str;
