#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
274-1: Goat Latin
Submitted by: Mohammad Sajid Anwar
You are given a sentence, $sentance.

Write a script to convert the given sentence to Goat Latin, a made up language similar to Pig Latin.

Rules for Goat Latin:

1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa" to
   the second word, etc etc.
Example 1
Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"
Example 2
Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
Example 3
Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"
=end comment

my @Test =
    "I love Perl",
            "Imaa ovelmaaa erlPmaaaa",
    "Perl and Raku are friends",
            "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
    "The Weekly Challenge",
            "heTmaa eeklyWmaaa hallengeCmaaaa",
;
plan @Test ÷ 2;

sub shift-push( Any(Str) $a --> Str) {
    $a.substr(1) ~ $a.substr(0,1);
}

sub task( $sentence --> Str) {
    my Str $ret;
    for $sentence.words -> $a is copy {
        state $suffix-length;
        ++$suffix-length;
        if $a !~~ / ^ <[ a e i o u A E I O U ]> / {
           $a = shift-push( $a);
        }
        $ret ~= $a ~= 'ma' ~ ('a' x $suffix-length) ~ ' ';
        LAST $ret.=chop: 1;
    }
    $ret;
}

for @Test -> $in, $exp {
    is task($in), $exp, "$exp <- $in";
}

done-testing;

my $sentence = "built for two";
say qq{\nInput: \$sentence = "$sentence"\nOutput: }, task($sentence), qq{"};

