#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
375-1: Single Common Word       Submitted by: Mohammad Sajid Anwar
You are given two array of strings.
Write a script to return the number of strings that appear exactly once in each of the two given arrays. String comparison is case sensitive.
=end comment 

my @Test =
    #    a                           b                             exp
    ("apple", "banana", "cherry"),  ("banana", "cherry", "date"),   2,
    ("a", "ab", "abc"),             ("a", "a", "ab", "abc"),        2,
    ("orange", "lemon"),            ("grape", "melon"),             0,
    ("test", "test", "demo"),       ("test", "demo", "demo"),       0,
    ("Hello", "world"),             ("hello", "world"),             1,
    ("", "world"),                  ("", "world"),                  2,
    ("", "world"),                  ("", ""),                       0,
    (),                             (),                             0,
;
plan +@Test ÷ 3;

sub task( BagHash:D() $a, BagHash:D() $b is copy -->Int:D ) {
     + [∩] do for $a, $b { .grep( *.value == 1).BagHash }
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "{$exp // $exp.^name()} <- $a.raku() ∘∘ $b.raku()";
}
done-testing;

my @array1 = ("test", "test", "demo",         'ha', 'hi',       'hmm');
my @array2 = ("test",         "demo", "demo", 'ha', 'hi', 'hi', 'hmm');

say qq{\nInput: @array1 = ["@array1.join( '", "')"];},
  ~ qq{\n       @array2 = ["@array2.join( '", "')"];},
  ~ qq{\nOutput: &task( @array1, @array2)};
