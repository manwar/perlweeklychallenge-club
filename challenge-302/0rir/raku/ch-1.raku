#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
302-1: Ones and Zeroes  Submitted by: Mohammad Sajid Anwar
You are given an array of binary strings, @str, and two integers, $x and $y.

Write a script to return the size of the largest subset of @str such that there are at most $x 0’s and $y 1’s in the subset.

A set m is a subset of n if all elements of m are also elements of n.
Example 1
Input: @str = ("10", "0001", "111001", "1", "0")
       $x = 5
       $y = 3
Output: 4

The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")
Example 2
Input: @str = ("10", "1", "0")
       $x = 1
       $y = 1
Output: 2

The largest subset with at most one 0's and one 1's:
("1", "0")
=end comment

my @Test =
  # exp zed one  L-o-Str
    4,  5,  3,  ("10", "0001", "111001", "1", "0"),     #examples
    2,  1,  1,  ("10", "1", "0"),

    3,  3,  4,  ( '0', '0', '11', '00000'),             #oversize
    3,  3,  3,  ( '0', '0', '11',          '11111'),
    3,  3,  3,  ( '0', '0', '11', '00000', '11111'),
;

my @Default  =  '0', '0', '11';
my @Test-def =
  # exp zed one
    0, -1, -1,      # < 1 multi's
    0, -1,  1,
    0,  1, -1,

    1,  1,  0,      # logic per arg s/b same
    2,  2,  0,
    2,  3,  0,
    2,  4,  0,

    0,  0,  0,      # general
    0,  0,  1,
    1,  0,  2,
    1,  0,  3,
    1,  0,  4,

    1,  1,  1,
    2,  1,  2,
    2,  1,  3,
    2,  1,  4,

    2,  2,  1,
    3,  2,  2,
    3,  2,  3,
    3,  2,  4,

    2,  3,  1,
    3,  3,  2,
    3,  3,  3,
    3,  3,  4,
;
plan @Test ÷ 4 + @Test-def ÷ 3;


# Reform strs to dyads like [ Zed-count, One-count].
sub reform( @str is copy --> Array ) {
    @str.=map( {
        my $z = Int( .split('').grep('0'));
        [ $z, .chars - $z ]
    });
}

multi task($zeds where * < 0, $ones, @str -->0) {}
multi task($zeds, $ones where * < 0, @str -->0) {}

multi task($zeds, $ones, @str --> Int)  {
    my $*zed-max = $zeds;
    my $*one-max = $ones;
    my @dual = @str.&reform;

    for @str.elems...1 -> $e {
        for @dual.combinations( $e ) -> @set {
             return $e if evaluate( @set );
        }
    }
    return 0;
}

sub evaluate( @zo --> Bool:D ) {
    @zo[*;0].sum ≤ $*zed-max and @zo[*;1].sum ≤ $*one-max
}


for @Test -> $exp, $zeds, $ones, @in {
    is task($zeds, $ones, @in), $exp,
            "$exp <- 0s=$zeds 1s=$ones ∘ @in[]";
}
for @Test-def -> $exp, $zeds, $ones {
    is task($zeds, $ones, @Default), $exp,
            "$exp <- 0s=$zeds 1s=$ones ∘ @Default[]";
}
done-testing;


my @str = '0', '0', '11', '00000', '11111';
my $zeds = 4;
my $ones = 3;
say "\nInput: @str = @str.raku()\n"
    ~ "       \$zeds = $zeds\n"
    ~ "       \$ones = $ones\n"
    ~ "Output: { task $zeds, $ones, @str }";
