#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
315-2: Find Third           Submitted by: Mohammad Sajid Anwar
You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in sequence to the given two words.


Example 1
Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
       $first = "my"
       $second = "favourite"
Output: ("language", "too")

Example 2
Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
       $first = "a"
       $second = "beautiful"
Output: ("doll", "princess")

Example 3
Input: $sentence = "we will we will rock you rock you.",
       $first = "we"
       $second = "will"
Output: ("we", "rock")

=end comment

my @Test =
    {
    sentence => "Perl is a my favourite language but Python is my favourite too.",
    first => "my",
    second => "favourite",
    exp => ("language", "too"),
    },{
    sentence => "Barbie is a beautiful doll also also a beautiful princess.",
    first =>  "a",
    second => "beautiful",
    exp=> ("doll", "princess"),
    },{
    sentence => "we will we will rock you rock you.",
    first => "we",
    second => "will",
    exp => ("we", "rock"),
    },{
    sentence => "you rock.",
    first => "you",
    second => "rock",
    exp => (),
    },{
    sentence => "all about nothing.",
    first => "you",
    second => "rock",
    exp => (),
    },{
    sentence => "",
    first => "you",
    second => "rock",
    exp => (),
    }
;
plan @Test.Int;

multi task( $text where (!$$text.defined or $text eq ''), $word1, $word2) { [] }
multi task( $text,
            $word1 where (!$text.defined or $text eq '' ),
            $word2 where (!$text.defined or $text eq '' ) -->Array) { die }
multi task( $text, $word1, $word2 -->Array) {
    my @ret =();
    my $m = $text ~~ m:ov/ $word1 \s+ $word2 \s+ (\w+) { @ret.push: $0.Str } /;
    return  @ret;
}
for @Test -> %t {
    my ( $text, $w1, $w2, @exp) = %t< sentence first second exp>;
    is task( $text, $w1, $w2), @exp, "{@exp // @exp.^name()} <- $text∘$w1∘$w2";
}
done-testing;

my $sentence =  "we will we will rock you rock you.";
my $first = "we";
my $second = "will";

say qq{
Input: \$sentence = "we will we will rock you rock you.
       \$first = "$first"
       \$second = "$second"
Output: ("}, (task( $sentence, $first, $second)».Str).join( '", "'), '")';
