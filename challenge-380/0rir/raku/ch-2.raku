#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
380-2: Reverse Degree       Submitted by: Mohammad Sajid Anwar
You are given a string.
Write a script to find the reverse degree of the given string.

For each character, multiply its position in the reversed alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in the string. Sum these products for all characters in the string to get the reverse degree.

=end comment

my @Test =
    # in            $exp
    "z",              1,
    "a",             26,
    "bbc",          147,
    "racecar",      560,
    "zyx",           14,
    "",               0,
;
plan +@Test ÷ 2;

my $char2int = Map.new: ('z'…'a') [Z=>] (1…26);

sub task( Str:D $a -->Int:D) {
    my $ret = 0;
    for 1..$a.chars -> \k {
        $ret +=  k × $char2int{ $a.substr( k-1,1) }
    }
    $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;

my $str = "bbc";
say qq{\nInput: \$str = "$str"\nOutput: &task( $str)};
