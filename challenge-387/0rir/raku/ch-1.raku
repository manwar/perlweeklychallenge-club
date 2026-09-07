#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
387-1: Rearrange Binary String     Submitted by: Mohammad Sajid Anwar

You are given a binary string. Write a script to re-arrange the given
binary string that all occurrences of “01” are simultaneously replaced
with “10” until no occurrences of “01” exist. Finally return the total
steps needed.
=end comment

my @Test =
    "111000",   0,
    "00011",    4,
    "01011",    3,
    "010101",   3,
    "00001",    4,

    "10",       0,
    "01",       1,
    "001",      2,
    "010",      1,
    "011",      2,
    "101",      1,
    "000001",   5,
    "000011",   5,
    "000111",   5,
    "001111",   5,
    "011111",   5,
    "01111111", 7,
    "000111000111",   8,
;
plan +@Test ÷ 2;

sub task( Str:D() $a is copy -->Int:D) {
    my $ret = 0;
    $a ~~ s/ 0+ $//;
    while not so $a ~~ m/ ^ 1+  0* $ / {
        $a ~~ s:g/01/10/;
        ++$ret;
    }
    $ret;
}


for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;
=finish

Input: $str = "010101"
Output: 3

Input: $str = "010101"
Output: 3
