#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use lib $?FILE.IO.cleanup.parent;
use Test;

=begin comment
Edited for space.
342-1: Balance String      Submitted by: Mohammad Sajid Anwar
You are given a string made up of lowercase English letters and digits only.

Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.
=end comment

my @Test =
    # in                  exp
    "a0b1c2",           "0a1b2c",
    "abc12",            "a1b2c",
    "0a2b1c3",          "0a1b2c3",
    "1a23",             "",
    "ab123",            "1a2b3",
    "abc1",             "",
    "5",                "5",            # For empty string and
    "a",                "a",            # single char string inputs the
    "",                 Str,            # results are not well specified.
;
plan +@Test ÷ 2;

multi task( ''                            ) { Str }     # XXX
multi task( Str:D $in where *.chars == 1  ) { $in }     # XXX
multi task( Str:D $in             -->Str:D) {
    my @a = $in.comb( /<:Ll>/).sort;
    my @n = $in.comb( /<:Nd>/).sort;
    my $ret = '';
    given my $diff-len = @a - @n {
        when $diff-len.abs > 1 { return $ret; }
        when  0  { return (@n Z @a).flat.join }
        when  1  { return (@a Z @n).flat.join ~ @a.tail }
        when -1  { return (@n Z @a).flat.join ~ @n.tail }
        default  { die 'Blame the programmer!' }
    }
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "ab123";

say qq|\nInput: \$str = "$str"\nOutput: "{task $str}"|;
