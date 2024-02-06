#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
254-2: Reverse Vowels       Submitted by: Mohammad S Anwar
You are given a string, $s, reverse all the vowels (a, e, i, o, u) in
the given string.

Example 1
Input: $s = "Raku"
Output: "Ruka"
Example 2
Input: $s = "Perl"
Output: "Perl"
Example 3
Input: $s = "Julia"
Output: "Jaliu"
Example 4
Input: $s = "Uiua"
Output: "Auiu"
=end comment

my @Test = [
    "",         "",
    "' '",      "' '",
    "Url",      "Url",
    "url",      "url",
    "Raku",     "Ruka",
    "RAku",     "RUka",
    "RAkU",     "RUkA",
    "RakU",     "RukA",
    "Perl",     "Perl",
    "Julia",    "Jaliu",
    "Uiua",     "Auiu",  
    "Juniper tea", "Janeper tiu"
];

plan @Test ÷ 2;

sub vowel-reverse( Str $a --> Str) {
    my @word   = $a.comb;
    my @vowel  = @word.grep( / <[aAeEiIoOuU]>/)».lc;    
    return $a if +@vowel.chars <= 1;

    my @uc-pos = @word.grep( /<[AEIOU]>/, :k);
    my @v-pos  = @word.grep: / <[aAeEiIoOuU]>/, :k ;
    @word[@v-pos] = @vowel.reverse;
    @word[@uc-pos]».=uc;
    return @word.join;
}

for @Test -> $in, $exp {
    is vowel-reverse($in), $exp, "$in -> $exp";
}
done-testing;

my $s = qq{Et's nit POERL at's Paarl, but that wes tikan se ot's Pirl.};

say "\nInput: \$s = $s\nOutput: &vowel-reverse( $s)";

my $r = qq{It's not PEARL it's Pearl, but that was taken so it's Perl.};
die unless vowel-reverse($s) eq $r;
exit;

