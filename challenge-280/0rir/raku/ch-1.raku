#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
280-1: Twice Appearance             Submitted by: Mohammad Sajid Anwar
You are given a string, $str, containing lowercase English letters only.

Write a script to print the first letter that appears twice.

Example 1
Input: $str = "acbddbca"
Output: "d"
Example 2
Input: $str = "abccd"
Output: "c"
Example 3
Input: $str = "abcdabbb"
Output: "a"
=end comment

my @Test =
    #   $in         $exp
    "acbddbca",     "d",
    "abccd",        "c",
    "abcdabbb",     "a",
    "abcdefgh",     Str,
    "",             Str,
;
my @Mix =
    "abcdefghiFi", 'f',
;
plan @Test * 1.5 + @Mix;

multi task( Str:D $in, Bool:D :$case-force! ) { task( $in.lc); }
multi task( Str:D $in, Bool:D :$case-ck! ) {
    die qq{ERROR: "$in" is not lowercase.} if $in ne $in.lc;
    task( $in);
}
multi task( Str:D $in --> Str ) {
    my $s = ().SetHash;
    my $prev = $s.elems;
    for 0..$in.chars -> \i {
        my $c = $in.substr( i, 1);
        $s.set: $c;
        return $c if $s.elems == $prev;
        ++$prev;
    }
    Str;
}

for @Test -> $in, $exp {
    is task($in), $exp,                  ($exp // "(Str)") ~ " <- $in";
    is task($in, :case-ck),
                  $exp, ":case-ck "    ~ ($exp // "(Str)") ~ " <- $in";
    is task($in, :case-force),
                  $exp, ":case-force " ~ ($exp // "(Str)") ~ " <- $in";
}
for @Mix  -> $in, $exp {
    dies-ok { task($in, :case-ck)},   ":case-ck dies <- $in";
    is task($in, :case-force), $exp,  ":case-force $exp <- $in";
}
done-testing;

my $str = 'abcdefghijklmnopqrstuvwxyzs';
say qq{\nInput: \$str = "$str"\nOutput: "&task($str)"};

