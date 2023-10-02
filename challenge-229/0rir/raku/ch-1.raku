#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
229-1: Lexicographic Order         Submitted by: Mohammad S Anwar

Given an array of strings, delete each element which is not lexicographically
sorted (forwards or backwards) and return the count of deletions.

Example 1
Input: @str = ("abc", "bce", "cae")
Output: 1

In the given array "cae" is the only element which is not lexicographically
sorted.

Example 2
Input: @str = ("yxz", "cba", "mon")
Output: 2

In the given array "yxz" and "mon" are not lexicographically sorted.
=end comment

my @Test =
    1, ("abc", "bce", "cae"),
    2, ("yxz", "cba", "mon"),
    3, «bac bcd ced def feg»,
    4, «bac cbd ced def feg»,
    5, «bac cbd ced edf feg»,
    0, «abc bcd cde def efg»,
    0, «A Bb cCc ddDd eeeeE»,
;

plan @Test ÷ 2;

sub func( @w -->Int) {
 #  +@w.grep: {             .fc.comb.sort.join() ~~ ( $_.fc, .fc.flip).none};
   +@w.grep: {my $w = $_; $w.fc.comb.sort.join() ~~ ( $w.fc, $w.fc.flip).none};
}

for @Test -> $exp, @in {
    is func(@in), $exp, "$exp <- @in.raku()";
}
done-testing;

my @str = «a b cc ccC aBc cba ab cb»;
say "\nInput: @str = @str[]\nOutput: &func(@str)";

exit;

