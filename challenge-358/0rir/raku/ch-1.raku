#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
258-1: Max Str Value        Submitted by: Mohammad Sajid Anwar
You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given array. The numeric representation of the string, if it comprises of digits only otherwise length of the string.
=end comment

my @Test =
        # in                                   exp
        ("123", "45", "6").Array,              123,
        ("abc", "de", "fghi").Array,             4,
        ("0012", "99", "a1b2c").Array,          99,
        ("x", "10", "xyz", "007").Array,        10,
        ("hello123", "2026", "perl").Array,   2026,
        ("12i", "9", "mate").Array,              9,
;
plan +@Test ÷ 2;

# Strings denoting imaginary numbers are considered non-numeric.
sub task( Array $a --> Int) {
    (my @copy = @$a)
        .map({ $_ = ( try { .Int } === Nil) ?? .chars !! .Int })
        .max
}

for @Test -> @in, $exp {
    is task( @in), $exp, "{$exp // $exp.^name()} <- @in.raku()";
}

done-testing;

my @string = "0012", "99", "a1b2c";

say "\nInput: @string = (\"@string.join( '", "')\")";
say   "Output: ", task @string;
