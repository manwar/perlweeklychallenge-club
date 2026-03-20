#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
365-2: Valid Token Counter          Submitted by: Mohammad Sajid Anwar

You are given a sentence.

Write a script to split the given sentence into space-separated tokens and count how many are valid words. A token is valid if it contains no digits, has at most one hyphen surrounded by lowercase letters, and at most one punctuation mark (!, ., ,) appearing only at the end.
=end comment

my @Test =
    "cat and dog",                  3,
    "a-b c! d,e",                   2,
    "hello-world! this is fun",     4,
    "ab- cd-ef gh- ij!",            2,
    "wow! a-b-c nice.",             2,
;

my @T = <a ab a-b a. a! a, a? a'>;
my @F = <1 - a- -a -a-b a-b- ab- a--a a'a a1 1a a1a >;

plan  @T + @F + @Test ÷ 2;

my regex wordish { ^
                   [ <:L>+ '-' ]?
                   <:L>+
                   <:P - [\-] >?
                   $
}

sub task( Str:D() $a --> Int) { + $a.words.grep( / <wordish> / ); }

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
for @T -> $in { ok task( $in),  "\"$in\" match"; }
for @F -> $in { ok !task( $in), "\"$in\" no match"; }

done-testing;


my $str = "wow! a-c nice.";

say qq{\nInput: \$str = "$str"\nOutput: }, task $str;

