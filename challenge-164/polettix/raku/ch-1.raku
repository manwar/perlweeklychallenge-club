#!/usr/bin/env raku
use v6;

sub is-palindrome (Int $n) { $n.Str eq $n.Str.flip }

sub MAIN (Int $max = 989) {
   (2 .. $max).grep({.is-prime && is-palindrome($_)}).put;
}
