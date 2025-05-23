#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
322-Task 1: String Format       Submitted by: Mohammad Sajid Anwar

You are given a string and a positive integer.

Write a script to format the string, removing any dashes, in groups of size given by the integer. The first group can be smaller than the integer but should have at least one character. Groups should be separated by dashes.

Example 1
Input: $str = "ABC-D-E-F", $i = 3
Output: "ABC-DEF"

Example 2
Input: $str = "A-BC-D-E", $i = 2
Output: "A-BC-DE"

Example 3
Input: $str = "-A-B-CD-E", $i = 4
Output: "A-BCDE"

=end comment

my @Test =
    "ABC-D-E-F",    3,  "ABC-DEF",
    "A-BC-D-E",     2,  "A-BC-DE",
    "-A-B-CD-E",    4,  "A-BCDE",
    'A-B',          1,  'A-B',
    'A-B',          2,  'AB',
    'A-B',          3,  'AB',
    'A',            5,  'A',
;
plan @Test ÷ 3;

sub task( Any:D(Str) $s where * ne '', Any:D(Int) $i, :$sep = '-' -->Str) {
    $_ = $s.subst( $sep, '', :g).flip;
    .comb( $i, :partial).join($sep).flip;
}

for @Test -> $in, $siz, $exp,{
    is task( $in, $siz), $exp, "{$exp // $exp.^name()} <- $in ∘∘ $siz";
}
done-testing;


my $str = "-A-B-CD-E";
my $i = 4;

say qq{\nInput: \$str = "$str" \$i = $i\nOutput: "}, &task($str, $i), '"';

