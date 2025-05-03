#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
319-1: Word Count           Submitted by: Mohammad Sajid Anwar

You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or ending with a vowel.


Example 1
Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2

The words are "unicode" and "raku".

Example 2
Input: @list = ("the", "weekly", "challenge")
Output: 2

Example 3
Input: @list = ("perl", "python", "postgres")
Output: 0
=end comment

# A E I O U and sometimes Y and W too
#
# Casual research indicates that the 'rules' around the classification
# of vowelness are dictated by the letter's pronunciation.  As such the
# rules might be considered responsive to practice in regard to the
# semi-vowels.  My review only found materials focused on education up to
# a level of competency which was undefined but went beyond a lay
# person's need.
#   For context: 'W' as a semi-vowel, is an addition to the rules of which
# I was previously unaware.

my @Test =
    # in                                    exp
    ("unicode", "xml", "raku", "perl"),     2,
    ("the", "weekly", "challenge"),         3, # FIXED y is usually a vowel
    ("perl", "python", "postgres"),         0,
    <Unicode Raku Java Ruby Go Ada Awk>,    7,
    <Hex Assembly Basic Prolog sh Sed Awk
        C Perl Pascal Smalltalk Bash Sql
        plsql Sather Raku >,                3,
    < Awk Aid>,                             2,
    < Foxpro Raku Solidity Bowwow>,         4,
    ( "years", "test"),                     0,
    ( '', ),                                0,
    (),                                     0,
;

plan @Test ÷ 2;

# vowel-edged -- grammar accepting a string which is all alphabetic, and
#               either begins and/or ends with a vowel.
grammar vowel-edged {
    token TOP   { ^^ <vowel-edged> $$ } # vowel mid-stuff vowel
    token vowel { <[aeiouAEIOU]> }      # vowels
    token y     { <[yY]> }              # usu. vowel
    token w     { <[wW]> }              # usu. consonant 
    regex vowel-edged {
            [ <vowel>  <:L>*                              ]
            ||
            [ <:L>+    [ <vowel> <w> || <vowel> || <y> ]  ]
    }
}

sub task( @w --> Int) {
    my $count = 0;
    for @w -> $w {
        my $m = vowel-edged.parse( $w);
        ++ $count if $m.defined;
    }
    $count;
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}
done-testing;

my @list =   < Foxpro Raku Solidity Bowwow>;

say qq{\nInput: @list = ("@list.join('", "')")\nOutput: &task( @list)}

