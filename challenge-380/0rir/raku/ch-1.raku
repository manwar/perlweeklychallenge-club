#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
380-1: Sum of Frequencies       Submitted by: Mohammad Sajid Anwar
You are given a string consisting of English letters.
Write a script to find the vowel and consonant with maximum frequency. Return the sum of two frequencies.

Example 1
Input: $str = "banana"
Output: 5

Vowel: "a" most appears at 3 times.
Consonant: "n" most appears at 2 times.
Sum is 5

=end comment

my @Test =
    "banana",   5,
    "teestett", 7,
    "aeiouuaa", 3,
    "rhythm",   2,
    "x",        1,
    "",         0,
    "tEesteTt", 7,
    "bbiixxaa", 4,
;

plan +@Test ÷ 2;

only task( Str:D $a -->Int:D) {
    my @a = $a.fc.comb;
    my $v = BagHash.new: @a.grep: * ~~ / <[aeiou]> /;
    my $c = BagHash.new: @a.grep: * ~~ / <-[aeiou]> /;

    ($v.values.max == -Inf ?? 0 !!  $v.values.max)
      +
    ($c.values.max == -Inf ?? 0 !!  $c.values.max)
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "teestett";
say qq{\nInput: \$str = "$str"\nOutput: &task($str)}

