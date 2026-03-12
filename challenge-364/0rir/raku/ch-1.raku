#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
364-1: Decrypt String       Submitted by: Mohammad Sajid Anwar
You are given a string formed by digits and ‘#'.
Write a script to map the given string to English lowercase characters following the given rules.
- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.
￼
Example 1
Input: $str = "10#11#12"
Output: "jkab"
=end comment

my @Test =
    # in             exp
    '1',            'a',
=begin x
=end x
    '12',           'ab',
    '123',          'abc',
    '1234',         'abcd',
    '12#',          "l",
    "10#11#",       "jk",
    "10#11#12#",    "jkl",
    "10#11#12#13#", "jklm",
    "10#11#1",      "jka",
    "10#11#12",     "jkab",
    "10#11#123",    "jkabc",
    "110#11#123",   "ajkabc",
    "1210#11#123",  "abjkabc",
    "110#1111#1",   "ajaaka",
    "1326#",        "acz",
    "1326#12",      "aczab",
    "1326#",        "acz",
    "1234526#",     "abcdez",
    "25#24#123",    "yxabc",
    "25#24#1234",   "yxabcd",
    "20#5",         "te",
    "1910#26#",     "aijz",
;
plan +@Test ÷ 2;

constant \OFFSET = 96;
constant \JOINT  = '#';

sub task ( Str:D() $a is copy -->Str:D) {
    $a.subst( :g, / (\d**2) <?before '#'> || ('#') || (\d) /,
                -> $m { $m.Str ne '#' ?? ($m.Str + 96).chrs !! '' } );
}

for @Test -> $in, $exp {
   is task( $in), $exp, "{$exp // $exp.^name()} <- $in";
}
done-testing;

my $str = "10#1311#112#";
say qq{\nInput: \$str = "$str"\nOutput: }, task $str;
