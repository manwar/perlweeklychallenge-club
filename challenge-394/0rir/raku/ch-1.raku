#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
394-1: Alternate Case       Submitted by: Mohammad Sajid Anwar

You are given a string containing an equal number of uppercase and lowercase English letters.
Write a script to the minimum number of adjacent character swaps needed to turn the given string into an alternate case string.
=end comment

my @Test =
    # in            exp
    "aAbB",         0,
    "AAbb",         1,
    "AAAbbb",       3,
    "aABb",         1,
    "bBBAaa",       2,

    "Aa",           0,
    "AAAAAaaaaa",   10,
    "aaaaaAAAAA",   10,
;
plan @Test ÷ 2;

sub task( Any:D(Str) $a -->Int) {
    my @char = $a.comb;
    return min examine( True), examine( False);

            sub examine( Bool:D $uc-first)  {
                my ($ret, $target) = (0, 0);
                for 0..^@char -> \i  {
                    my $lc-q = ( so @char[i] ~~ /^ <:Ll> $/) ?? 1 !! 0;
                    if $lc-q == $uc-first {
                        $ret  += abs( i - $target);
                        $target += 2;
                    }
                }
                return $ret;
            }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in";
}
done-testing;

my $str = "aABbaaaaaAAAAAaABb";
say qq{\nInput: \$str = "$str"\nOutput: }, task $str;
