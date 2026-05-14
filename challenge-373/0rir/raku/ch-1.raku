#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
373-1: Equal List           Submitted by: Mohammad Sajid Anwar
You are given two arrays of strings.
Write a script to return true if the two given array represent the same strings otherwise false.
=end comment

my @Test =
    # $a                        $b            $exp
    ("a", "bc"),            ("ab", "c"),     True,
    ("a", "b", "c"),        ("a", "bc"),     True,
    ("a", "bc"),            ("a", "c", "b"), False,
    ("ab", "c", ""),        ("", "a", "bc"), True,
    ("p", "e", "r", "l"),   ("perl",),       True,
    ("","",),               ("","",),        True,
;
plan +@Test ÷ 3;

sub task( List $a, List $b) {   $a.join eq $b.join }

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "{$exp // $exp.^name()} <- $a.raku() ∘∘ $b.raku()";
}
done-testing;

my @arr1 = "a", "bc";
my @arr2 = "a", "c", "b";

say "\nInput: @arr1 = (\"{@arr1.join( '", "')}\")"
   ~ "\n@arr2 = (\"{@arr2.join('", "')})\""
   ~ "\nOutput: ", task(@arr1, @arr2);
