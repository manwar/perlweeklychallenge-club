#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
314-Task 1: Equal Strings       Submitted by: Mohammad Sajid Anwar

You are given three strings.
You are allowed to remove the rightmost character of a string to make all equals.
Write a script to return the number of operations to make it equal otherwise -1.

Example 1
Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2

Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"
Example 2
Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1
Example 3
Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3
=end comment

my @Test =
    # s1      s2      s3        exp
    "abc",  "abb",  "ab",       2,
    "ayz",  "cyz",  "xyz",      Int,
    "yza",  "yzb",  "yzc",      3,
    "yzab", "yzbb", "yzcb",     6,
    "",     "",     "",         0,
    "abc",  "abc",  "abc",      0,
;
plan @Test ÷ 4;

sub task( Str:D $a, Str:D $b, Str:D $c -->Int) {
    return 0 if ($a, $b, $c).any eq '';
    my $mx-len = min ($a, $b, $c)».chars;
    my $chars =  sum ($a, $b, $c)».chars;
    my $common;
    for ^$mx-len {
        if [eq] ($a,$b,$c)».substr( $_,1) { ++$common; }
        else                              {   last;    }
    }
    return Int if ! $common.defined;
    $chars - 3 × $common;
}

for @Test -> $a, $b, $c, $exp {
    is task( $a, $b, $c), $exp, "{$exp // $exp.^name()} <- $a ∘ $b ∘ $c";
}
done-testing;

my ($s1, $s2, $s3) = 'abcd', 'abcd', 'abdd';
say qq{\nInput: \$s1 = "$s1", \$s2 = "$s2", \$s3 = "$s3"\n}
  ~ qq{Output: }, task $s1,$s2,$s3;

