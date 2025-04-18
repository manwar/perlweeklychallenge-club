#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
317-2: Friendly Strings         Submitted by: Mohammad Sajid Anwar
You are given two strings.
Write a script to return true if swapping any two letters in one string
match the other string, return false otherwise.

Example 1
Input: $str1 = "desc", $str2 = "dsec"
Output: true

Example 2
Input: $str1 = "fuck", $str2 = "fcuk"
Output: true

Example 3
Input: $str1 = "poo", $str2 = "eop"
Output: false

Example 4
Input: $str1 = "stripe", $str2 = "sprite"
Output: true

=end comment

my @Test =
    #  $a,      $b          $exp
    "desc",     "dsec",     True,
    "luck",     "lcuk",     True,
    "poo",      "eop",      False,
    "stripe",   "sprite",   True,
    "",         "",         False,
    "ab",       "a",        False,
    "ab",       "ab",       False,
    "ba",       "ab",       True,
    "abc",      "abc",      False,
    "abc",      "cab",      False,
    "abcd",     "abcde",    False,
;
plan @Test ÷ 3;

constant \Switch-ct = 2;

multi task( Str:D $a where *.chars < Switch-ct, Str:D $b -->False) {}
multi task( Str:D $a, Str:D $b where *.chars ne $a.chars -->False) {}
multi task( Str:D $a, Str:D $b --> Bool) {
    return False unless $a.comb.sort ~~ $b.comb.sort;
    Switch-ct == ( [Z,] $a.comb, $b.comb).grep: { .[0] ne .[1]};
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "{$exp // $exp.^name()} <- $a ∘∘ $b";
}
done-testing;

my $str1 = "desc";
my $str2 = "dsec";
say qq{\nInput: \$str1 = "$str1", \$str2 = "$str2"\n}
    ~ "Output: {task $str1, $str2 }";

