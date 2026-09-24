#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for brevity, clarity or no good reason.
392-1: Convert Palindrome
Submitted by: Mohammad Sajid Anwar

You are given a string.
Write a script to convert the given string to palindrome by
adding characters in front of it.
=end comment

my @Test =
    # in              exp
    "pinnipeds",    "sdepinnipeds",
    "abcd",         "dcbabcd",
    "bananas",      "sananabananas",
    "dissident",    "tnedissident",
    "cailliachs",   "shcailliachs",
    "a",            "a",
    "abc",          "cbabc",
    "aba",          "aba",
    "abba",          "abba",
    "abbaa",          "aabbaa",
    "",             "",
;
plan +@Test ÷ 2;

multi task( $a  where *.flip eq $a ) { $a }
multi task( $a ) {
    my $embedded = '';                          # largest prefix palindrome
    my @e-tail = $a.indices( $a.substr( 0,1));  # regex likely doable & better
    for @e-tail[@e-tail.end...^0] -> \t {
        my $flip-q = $a.substr( 0, t + 1);
        if $flip-q eq $flip-q.flip {
            return $a.substr( t+1).flip ~ $flip-q ~ $a.substr: t+1;
        }
    }
    return $a.flip ~ $a.substr( 1);
}

for @Test -> $in, $exp {
    is task( $in), $exp, " $exp <∘∘ $in";
}
done-testing;

my $str = "pinnipeds";
say qq{\nInput: \$str = "$str"\nOutput: "&task($str)"};
