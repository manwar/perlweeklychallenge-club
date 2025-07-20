#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
330-
You are given a string made up of one or more words separated by a single space.

Write a script to capitalise the given title. If the word length is 1 or 2 then convert the word to lowercase otherwise make the first character uppercase and remaining lowercase.


Example 1
Input: $str = "PERL IS gREAT"
Output: "Perl is Great"
=end comment

my @Test =
    #   in                      exp
    "PERL IS gREAT",        "Perl is Great",
    "RaKU iS sMorES",    "Raku is Smores",
;
plan +@Test ÷ 2;

sub task( $a is copy --> Str) {
    $a.lc.words.map( { .chars < 3 ?? $_ !! tc $_ }).join: ' ';
}

for @Test -> $in, $exp, {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $str = "PERL IS gREAT";
say qq{\nInput: \$str = "$str"\nOutput: "}, task($str), '"';

