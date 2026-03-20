#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
365-1: Alphabet Index Digit Sum     Submitted by: Mohammad Sajid Anwar

You are given a string $str consisting of lowercase English letters, and an integer $k.

Write a script to convert a lowercase string into numbers using alphabet positions (a=1 … z=26), concatenate them to form an integer, then compute the sum of its digits repeatedly $k times, returning the final value.

=end comment

my @Test =
    # in
    "abc",      1,      6,
    "az",       2,      9,
    "cat",      1,      6,
    "dog",      2,      8,
    "perl",     3,      6,
    "z",        1,      8,
    "z",        2,      8,
    "zz",       1,     16,
    "zz",       2,      7,
    "zzzz",     1,     32,
    "zzzz",     2,      5,
    "zzzz",     3,      5,
    "zzzzzzzz", 1,     64,
    "zzzzzzzz", 2,     10,
    "zzzzzzzz", 3,      1,
;
plan +@Test ÷ 3;

sub task( Str:D() $in    where * ~~ / ^ <:Ll>+ /,
          Int:D() $times where * > 0               -->Int:D)
{
    my $ret = [+] $in.comb».&{ (.ord -96 ) }.comb;
    for ^(-1 + $times) {
        $ret = [+] $ret.comb;
    }
    $ret;
}

for @Test -> $in, $times, $exp {
    is task( $in, $times), $exp, "$exp <- $in ∘∘ $times";
}
done-testing;

my $str = 'uvwxyz' x 13;
my $k = 2;

say qq{\nInput: \$str = "$str", \$k = $k\nOutput: }, task( $str, $k);
