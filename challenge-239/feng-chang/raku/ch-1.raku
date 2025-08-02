#!/bin/env raku

unit sub MAIN(Str:D $s1, Str:D $s2);

my @arr1 = $s1.words;
my @arr2 = $s2.words;

put @arr1.join eq @arr2.join;
