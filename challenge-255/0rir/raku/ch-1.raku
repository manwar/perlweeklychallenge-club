#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
255-1: Odd Character        Submitted by: Mohammad Sajid Anwar
You are given two strings, $s and $t. The string $t is generated using
 the shuffled characters of the string $s with an additional character.

Write a script to find the additional character in the string $t..

Example 1
Input: $s = "Perl" $t = "Preel"
Output: "e"
Example 2
Input: $s = "Weekly" $t = "Weeakly"
Output: "a"
Example 3
Input: $s = "Box" $t = "Boxy"
Output: "y"
=end comment

my @Test =
    "Perl",     "Preel",        "e",
    "Weekly",   "Weeakly",      "a",
    "Box",      "Boxy",         "y",
;

plan  @Test ÷ 3 + 3;

sub func( Any:D $long  where *.chars > 1,
          Any:D $short where  *.chars == $long.chars -1 --> Str) {
    return ($long.comb.Bag ∖ $short.comb.Bag).keys[0];
}

for @Test -> $short, $long, $exp {
    is func($long, $short), $exp, "$exp <- $long,  $short";
}
dies-ok { func( 'abc', 'abc') }, 'Bad data';
dies-ok { func( 'abc', 'abcd') }, 'Bad data';
dies-ok { func( 'a', 'a') }, 'Bad data';

done-testing;
my $s = 'abcdefghijjk';
my $t = 'abcdefghijjjk';
qq{\nInput: \$s = "$s" \$t = "$t"\nOutput: &func($t,$s)}.say;

exit;

