#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;
use Lingua::EN::Numbers;

=begin NOTE
    The examples imply a limited set of sentence constructions as the spec.
    In this implementation, case and whitespace variation is  allowed, and
    the hyphen is optional in "ty" phrases, i.e. 'fifty two'.
=end NOTE

=begin comment
May be edited for space.
363-1: String Lie Detector      Submitted by: Mohammad Sajid Anwar
You are given a string.
Write a script that parses a self-referential string and determines whether its claims about itself are true. The string will make statements about its own composition, specifically the number of vowels and consonants it contains.
=end comment

my @Test-True =
    # in
    "a — one vowel    \n and                  zero\tconsonants ",
    "aa — two vowels and zero \n\t consonants",
    "iv — one vowel and one consonant",
    "aeiou — five vowels and zero consonants",
    "aei — three vowels and zero consonants",
    "hello - two vowels and three consonants",
    "aeivou — five vowels and one consonant",
    "aeiou — five vowels and zero consonants",
    "aeivou — five vowels and one consonant",
    ('a' x 25) ~ ('zyx' x 5) ~ ' - twenty-five vowels and fifteen consonants',
;
plan  +@Test-True × 2;

my rule vowels { <[aeiou]> }
my rule consos { <[a..z]-[aeiou]> }
my rule divider { \s* ['-'| '—' ] \s* }

sub infix:<fccmp>( Str() $a, Str() $b) { $a.fc eq $b.fc }

sub task( Str(Any) $a is copy -->Bool) {
                # scrub
    my ($letters, $descr) = $a.split: / \s* ['-'| '—' ] \s* /, 2;
    $descr ~~ s:g/ \s+ / /;
    $descr.=trim;
    my $v-ct = $letters.comb.grep( / <vowels> /).Int;
    my $c-ct = $letters.comb.grep( / <consos> /).Int;

            # generate correct description
    my $want =
            ( cardinal($v-ct), ($v-ct == 1 ?? 'vowel'     !! 'vowels'    ),
              'and',
              cardinal($c-ct), ($c-ct == 1 ?? 'consonant' !! 'consonants'),
            ).join( ' ')
    ;

    return $want fccmp $descr if True;
    s:g/ '-' / / given $want;
    return $want fccmp $descr if True;
    False
}
for @Test-True -> $in {
    ok task( $in),            "True  <- $in.raku()";
    my $bad = $in.substr(1);
    nok task( $bad),  "False <- $bad.raku()";
}
done-testing;


my $str = "aeiou — five vowels and zero consonants";
say qq{\nInput: '\$str'= "$str"\n}
    ~   "Output: ", task $str;
