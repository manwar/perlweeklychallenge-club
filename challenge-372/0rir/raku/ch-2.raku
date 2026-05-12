#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
372-2: Largest Substring    Submitted by: Mohammad Sajid Anwar
You are given a string.
Write a script to return the length of the largest substring between two equal characters excluding the two characters. Return -1 if there is no such substring.

=end comment

my @Test =
    # in        exp
    "aaaaa",    3,
    "abcdeba",  5,
    "abbc",     0,
    "abcaacbc", 4,
    "abcdefg",  -1;
;
plan +@Test ÷ 2;

sub task(  Str:D() $a -->Int:D) { _task( $a) // -1 }

sub _task( Str:D() $a -->Int) {
    my $bh = $a.comb.BagHash;
    $bh.remove: $bh.keys;

    return Int if $bh ~~ ∅;

    my Int $ret;
    for $bh.keys -> $sentinel {
       my $m = $a ~~ / $sentinel .* $sentinel /;
       my $run = $m.to - $m.from - 2;
       quietly $ret = $run if !$ret.defined or $ret < $run;
    }
    $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my  $str = "abcdeba" x 100_000;
say qq{\nInput: \$str = "$str"\nOutput: }, task $str;

