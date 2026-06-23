#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
378-2 Sum of Words              Submitted by: Mohammad Sajid Anwar
You are given three strings consisting of lower case English letters ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.

=end comment

my @Test =
    { str1 => "acb",    str2 => "cba",  str3 => "cdb",  exp => True,},
    { str1 => "aab",    str2 => "aac",  str3 => "ad",   exp => True,},
    { str1 => "bc",     str2 => "je",   str3 => "jg",   exp => False,},
    { str1 => "a",      str2 => "aaaa", str3 => "aa",   exp => True,},
    { str1 => "c",      str2 => "d",    str3 => "h",    exp => False,},
    { str1 => "gfi",    str2 => "hbf",  str3 => "bdhd", exp => True,},
;
plan +@Test;

subset JStr of Str where * ~~ / ^ <[ a..j]>+ $ /;           # No empty strings allowed

my $jchar2digit = Map.new: ('a'...'j') [Z=>] (0...9);

sub jstr2int( $jstr -->Int:D ) {
    ( $jstr.comb».&{ $jchar2digit{ $_ }}).join.Int;
}
sub task( JStr:D() $add, JStr:D() $dend, JStr:D() $sum --> Bool:D ) {
    jstr2int( $sum) == sum ( $add, $dend)».&jstr2int;
}

for @Test -> $h {
    is task( $h<str1>, $h<str2>, $h<str3>), $h<exp>,
                "$h.{ 'exp'} ∘∘ $h<str1> + $h<str2> == $h<str3>"; }
done-testing;

my $str1 = "gfi";
my $str2 = "hbf";
my $str3 = "bdhd";

say qq{\nInput: \$str1 = "$str1", \$str2 = "$str2", \$str3 = "$str3"\nOutput: },
        task( $str1, $str2, $str3);
