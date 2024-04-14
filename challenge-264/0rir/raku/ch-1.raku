#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use Test;

=begin comment
264-1: Greatest English Letter      Submitted by: Mohammad Sajid Anwar
You are given a string, $str, made up of only alphabetic characters [a..zA..Z].
Write a script to return the greatest english letter in the given string.

A letter is greatest if it occurs as lower and upper case. Also letter ‘b’ is
greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.

Example 1
Input: $str = 'PeRlwEeKLy'
Output: L

There are two letters E and L that appears as lower and upper.
The letter L appears after E, so the L is the greatest english letter.
Example 2
Input: $str = 'ChaLlenge'
Output: L
Example 3
Input: $str = 'The'
Output: ''

=end comment

my @Test =
    '',                                 Str,
    'PeRlwEeKLy',                       'L',
    'ChaLlenge',                        'L',
    'The',                              Str,
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstyvwxy'
            .split( '').pick( *).join,  'Y',
;
plan @Test ÷ 2;

# Return the greatest letter else a Str type object.
sub greatest-letter( Str $a --> Str) {
    my Str @a = $a.comb;

    my Str @u                              # ucase candi's in greatest order
        = @a.grep( * ~~ / <:Lu> / ).sort.squish.reverse;
    return Str if @u ~~ Empty;

    my Str @l = @a.grep( * ~~ / <:Ll> / )».uc;  # lcase validators ucased
    return Str if @l ~~ Empty;

    @u.first( * ~~ @l.any) // Str;         # get 1st valid candi
}

for @Test -> $in, $exp {
    is greatest-letter($in), $exp, "$exp.raku() <- $in";
}

done-testing;

my $str = 'ABCDEFGHIJK=LMNPQRS-TUV1@WX0123:56789yzabcdefghijklmnopqrstyvwxyz'
        .split( '').pick( *).join;
say "\nInput: \$str = $str\nOutput: '", greatest-letter( $str) // '', "'";

exit;

