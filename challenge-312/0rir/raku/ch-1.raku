#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
312-1: Minimum Time             Submitted by: Mohammad Sajid Anwar
You are given a typewriter with lowercase english letters a to z arranged
in a circle.

Typing a character takes 1 sec. You can move pointer one character clockwise or anti-clockwise.

The pointer initially points at a.

Write a script to return minimum time it takes to print the given string.

Example 1
Input: $str = "abc"
Output: 5

The pointer is at 'a' initially.
1 sec - type the letter 'a'
1 sec - move pointer clockwise to 'b'
1 sec - type the letter 'b'
1 sec - move pointer clockwise to 'c'
1 sec - type the letter 'c'

Example 2
Input: $str = "bza"
Output: 7

Example 3
Input: $str = "zjpc"
Output: 34
=end comment

my @Test =
    # in        exp
    "abc",      5,
    "bza",      7,
    "zjpc",     34,
    "",         0,
;
plan @Test ÷ 2;

my %loca = ('a' … 'z') Z=> (1 … 26);

sub distance( @a --> Int) {
   my $d = abs %loca{@a[0]} - %loca{@a[1]};
   return ($d <  13 ?? $d !! 26 - $d);
}

sub task( Any(Str:D) $a -->Int:D) {
        $a.chars
        + sum do for ('a' ~ $a).comb.rotor(2 => -1) -> @d {
                    distance( @d)
                 }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in"
}

done-testing;

my $str = "zjpc";
say "Input: \$str = $str\nOutput: {task $str}";

