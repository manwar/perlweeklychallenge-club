#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
366-1: Count Prefixes       Submitted by: Mohammad Sajid Anwar
You are given an array of words and a string (contains only lowercase English letters).

Write a script to return the number of words in the given array that are a prefix of the given string.

=end comment

my @Test =
   # exp  str           array
    4,  "apple",    Array[Str]("a", "ap", "app", "apple", "banana"),
    0,  "bird",     Array[Str]("cat", "dog", "fish"),
    4,  "hello",    Array[Str]("hello", "he", "hell", "heaven", "he"),
    3,  "coding",   Array[Str]("", "code", "coding", "cod"),
    7,  "program",
        Array[Str]("p", "pr", "pro", "prog", "progr", "progra", "program"),
    2100000,  "program",
        Array[Str]( flat
            ("p", "pr", "pro", "prog", "progr", "progra", "program") xx 300000
        ),
;
plan +@Test ÷ 3;

sub task( Str:D() $str, Array[Str] $array -->Int:D) {
   sum $array».&{ $str.starts-with( $_) }
}

for @Test -> $exp, $in, $ary {
    if $exp < 50 {
        is task( $in, $ary) , $exp, "{$exp // $exp.^name()} <- $in ∘∘ $ary" ;
    } else {
        is task( $in, $ary) , $exp, "$exp <- $in ∘∘ $ary.gist()" ;
    }
}
done-testing;

my $array = Array[Str]("rack", "raku", "ra", "kudo", "perl");

my $str = "rakudo";

say qq{\nInput: @array = ("$array.join(', "')"), \$str = "$str"},
    qq{\nOutput: }, task($str, $array);
