#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
328-Task 1: Replace all ?
Submitted by: Mohammad Sajid Anwar
You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string doesn’t contain consecutive repeating characters.

Example 1
Input: $str = "a?z"
Output: "abz"

There can be many strings, one of them is "abz".
The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'.

Example 2
Input: $str = "pe?k"
Output: "peak"

Example 3
Input: $str = "gra?te"
Output: "grabte"

=end comment

my @Test =
    "",             "",
    "?",            "a",
    'z',            "z",
    "a?",           "ab",
    "?a",           "ba",
    "??",           "ab",
    "??a",          "aba",
    "b??",          "bab",
    "gra?te",       "grabte",
    "g?a?te",       "gbabte",
    "g???te",       "gabate",
    "g????e",       "gababe",
    "g?????",       "gababa",
    'xy',           'xy',
    "xyz",          "xyz",
    "azc",          "azc",
    "pe?k",         "peak",
    "??????",       "ababab",
    "g?a?te",       "gbabte",
;

plan +@Test ÷ 2;

# Here we follow a pattern suggested by the examples:  replace with the
# alphabetically first char that fits.

constant \fix-me       = '?';      # Char value needing replacement.
constant \first-choice = 'a';      # First choice for substitutions.
constant \filler       = '!';      # Out of band value for stand-ins.

sub alter( Any:D $q-mark is rw, :$prefix = filler, :$suffix = filler -->Nil) {
    $q-mark = first-choice;
    quietly ++$q-mark while $q-mark eq any($prefix, $suffix);
    return;
}

multi task( Str:D $a where *.chars == 0 -->Str) { '' }
multi task( Str:D $a where *.chars == 1 -->Str) {
    $a eq fix-me ?? first-choice !! $a ;
}
multi task( Str:D $a where *.chars ≥  1 --> Str) {
    my @s = $a.comb;

    if @s[0] eq fix-me { alter @s[0], :suffix(@s[1]) }

    for 1..(@s.end) -> \i {
        next if @s[i] ne fix-me;
        alter @s[i], :prefix(@s[i-1]), :suffix( @s[i+1]);
    }

    if @s[*.end] eq fix-me { alter @s[*.end], :prefix(@s[*.end-1]) }
    @s.join;
}

for @Test -> $in, $exp, {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}

done-testing;

my $str = "??????a?g?r???a?te?";

say qq{\nInput: \$str = "$str"\nOutput: "}, task($str), '"';
