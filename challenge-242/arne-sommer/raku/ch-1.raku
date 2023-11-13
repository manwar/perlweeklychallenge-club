#! /usr/bin/env raku

unit sub MAIN (Str $arr1, $arr2);

my @arr1 = $arr1.words>>.Int;
my @arr2 = $arr2.words>>.Int;

die "@arr1: Must be integers only" unless all(@arr1) ~~ Int;
die "@arr2: Must be integers only" unless all(@arr2) ~~ Int;

my @missing2 = (@arr1 (-) @arr2).keys.sort;
my @missing1 = (@arr2 (-) @arr1).keys.sort;

print "(";
print "[{ @missing2.join(", ") }]" if @missing2.elems;
print ", " if @missing2.elems && @missing1.elems;
print "[{ @missing1.join(", ") }]" if @missing1.elems;
say ")";
