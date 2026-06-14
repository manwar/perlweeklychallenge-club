#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
377-2: Prefix Suffix            Submitted by: Mohammad Sajid Anwar
You are given an array of strings.

Write a script to find if the two strings (str1, str2) in the given array such that str1 is prefix and suffix of str2. Return the total count of such pairs.
=end comment

=begin critique
    Just a naming issue:  Common definitions require something of a root
    word in the middle.
=end critique

my @Test =
    # in                            exp
    ["a", "aba", "ababa", "aa"],     4,
    ["pa", "papa", "ma", "mama"],    2,
    ["abao", "ab"],                  0,
    ["abab", "abab"],                1,
    ["ab", "abab", "ababab"],        3,
    ["abc", "def", "ghij"],          0,
    ["abc",],                        0,
;

plan +@Test ÷ 2;

sub task( @a is copy -->Int) {
    my $ret = 0;
    @a.=map( *.Str);
    
    for 0..^@a -> \i {
            my $me = @a[i];
        for @a[0..^i, i^..^@a].flat ->$e {
            next unless $me.chars ≤ $e.chars
                    and $e ~~ / ^ $me /
                    and $e ~~ / $me $ /;
            $ret += 1;
            $ret -= .5 if $e eq $me;
        }
    }
    $ret.narrow;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "$exp <- $in.raku()";
}
done-testing;
my @array = ("ab", "abab", "ababab");

say qq{\nInput: @array = @array.raku()\nOutput: }, task @array;
