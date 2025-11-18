#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
348-1: String Alike         Submitted by: Mohammad Sajid Anwar
You are given a string of even length.

Write a script to find out whether the given string can be split into two halves of equal lengths, each with the same non-zero number of vowels.
=end comment

my @Test =
    # in            exp
    "textbook",         False,
    "book",             True,
    "AbCdEfGh",         True,
    "rhythmmyth",       False,
    "UmpireeAudio",     False,

    "ai",               True,
;
plan +@Test ÷ 2;

sub task( Str $a where { .chars > 1 and .chars %% 2 } --> Bool) {
    my ( $l, $r)
    =   do for $a.substr( 0, $a.chars/2), $a.substr( $a.chars/2) {
               ( m:g:i/<[aeiou]>/ ).elems;
        };
    $l == $r ≠ 0
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "book";

say qq{\nInput: \$str = "$str"\nOutput: { &task $str }};

