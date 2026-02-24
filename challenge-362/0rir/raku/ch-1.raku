#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
Task 1: Echo Chamber        Submitted by: Mohammad Sajid Anwar
You are given a string containing lowercase letters.
Write a script to transform the string based on the index position of each character (starting from 0). For each character at position i, repeat it i + 1 times.

=end comment

my @Test =
    "abca",     "abbcccaaaa",
    "xyz",      "xyyzzz",
    "code",     "coodddeeee",
    "hello",    "heelllllllooooo",
    "a",        "a",
;
plan +@Test ÷ 2;

sub task(  Str:D(Any) $a where *.chars > 0 -->Str) {
    my @a = $a.comb;
    my $i = 1;
    (   for @a -> $e is rw {
            $e = $e x $i++;
        }
    ).join;
}
for @Test -> $in, $exp {
    is task(  $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}

done-testing;

my $input = "code";
say qq{\nInput: "$input"\nOutput: "&task($input)"\n};
