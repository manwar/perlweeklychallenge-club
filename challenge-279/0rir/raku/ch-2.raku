#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
279 2: Split String             Submitted by: Mohammad Sajid Anwar

Given a string, $str, split the given string into two containing
exactly same number of vowels and return true if you can otherwise false.

Example 1
Input: $str = "perl"
Ouput: false
Example 2
Input: $str = "book"
Ouput: true

Two possible strings "bo" and "ok" containing exactly one vowel each.
Example 3
Input: $str = "good morning"
Ouput: true

Two possible strings "good " and "morning" containing two vowels each or "good m" and "orning" containing two vowels each.k
=end comment

my @Test =
    # in        expect
    Str,        Bool,
    '',         False,
    ' ',        False,
    ',1,1',     False,
    'o',        False,
    'oo',       True,
    'o1o',      True,
    'ooo',      False,
    'o1oo',     False,
    "perl",     False,
    "book",     True,
    'aeiouAEIOU',        True,
    "good morning",      True,
    "Good mOrning",      True,
    "Go123od m,Orn:ing", True,
    ('aeiouAEIOU' x 10), True,
    ('aeiouAEIOU' x 10) ~ 'a', False,
;
plan @Test ÷ 2;

multi task( Str:U $in ) { Bool }
multi task( Str:D $in --> Bool) {
   my \v-ct := +$in.comb.grep( /:i <[aeiou]> / );
   return True if v-ct %% 2 and v-ct > 1 ;
   False;
}

for @Test -> $in, $exp {
    is task($in), $exp, ($exp // '(Bool)') ~ "<- " ~ ($in // '(Bool)').raku
}
done-testing;

my $str = 'x';
say "\nInput: \$str = $str\nOutput: ", task $str;
