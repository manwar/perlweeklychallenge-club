#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
328-Task 2: Good String
Submitted by: Mohammad Sajid Anwar
You are given a string made up of lower and upper case English letters only.
Write a script to return the good string of the given string. A string is called good string if it doesn’t have two adjacent same characters, one in upper case and other is lower case.
UPDATE [2025-07-01]: Just to be explicit, you can only remove pair if they are same characters, one in lower case and other in upper case, order is not important.
Example 1
Input: $str = "WeEeekly"
Output: "Weekly"
We can remove either, "eE" or "Ee" to make it good.
Example 2
Input: $str = "abBAdD"
Output: ""
We remove "bB" first: "aAdD"
Then we remove "aA": "dD"
Finally remove "dD".
Example 3
Input: $str = "abc"
Output: "abc"
=end comment

my @Test =
        # $in           $exp
    "WeEeekly",         "Weekly",
    "abBAdD",           "",
    "abc",              "abc",
    'abcdefghHGFEDCBa', 'aa',
    'bcdefghHGFEDCBa',  'a',
    'abcdefghHGFEDCB',  'a',
    "XxabBAdD",         '',
    "XxnabBAmdD",       'nm',
    "AaXxnabBAmdDzZ",   'nm',
;
plan +@Test ÷ 2;

constant XCASE = 32;

sub task( Str $a is copy --> Str) {
    my $unchanged;
    repeat {
        $unchanged = $a;
        $a ~~ s:g/ (<:L>)(<:L>) <?{ XCASE == abs($0.ord-$1.ord)}>//;
    } until  $a eq $unchanged;
    $a;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "AaaAaBbbbBCcc";

say qq{\nInput: \$str = "$str"\nOutput: "}, task( $str), '"';

