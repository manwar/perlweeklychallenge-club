#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
316-2: Subsequence      Submitted by: Mohammad Sajid Anwar

You are given two string.
Write a script to find out if one string is a subsequence of another.
A subsequence of a string is a new string that is formed from the original string
by deleting some (can be none)  of the characters without disturbing the relative
positions of the remaining characters.

Example 1
Input: $str1 = "uvw", $str2 = "bcudvew"
Output: true

Example 2
Input: $str1 = "aec", $str2 = "abcde"
Output: false

Example 3
Input: $str1 = "sip", $str2 = "javascript"
Output: true

=end comment

my @Test =
    "uvw",      "bcudvew",      True,
    "aec",      "abcde",        False,
    "sip",      "javascript",   True,
    'uvw',      'uvw',          True,
    'a',        'a',            True,
    'aaa',      'aaaa',         True,
    'a',        'b',            False,
    'aa',       'a',            False,
    '',         'a',            Bool,
    'a',        '',             Bool,
    Any,        'a',            Bool,
    'a',        Any,            Bool,
    Any,        Any,            Bool,
;

plan @Test ÷ 3;

multi task( Any:U $subq, Any:D $str) { Bool }
multi task( $subq,       Any:U $str) { Bool }
multi task( '',          $str      ) { Bool }
multi task( $subq,       ''        ) { Bool }
#multi task( Any:D $subq, Any:D $str where *.chars < $subq.chars) { False }
multi task( Any:D $subq,  Any:D $str -->Bool)             {
    so $str ~~ EVAL '/' ~ $subq.comb.join( ' .*? ' ) ~ '/';
}

for @Test -> $sub, $str, $exp {
    is task( $sub, $str), $exp,
            "{$exp // $exp.^name()} <- $sub.raku() ∘∘ $str.raku()";
}
done-testing;

my $s1 = "avast";
my $s2 = "javascript";
say qq{\nInput: \$str1 = "$s1", \$str2 = "$s2"\nOutput: &task($s1, $s2)};


