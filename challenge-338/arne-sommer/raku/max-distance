#! /usr/bin/env raku

unit sub MAIN ($arr1, $arr2);

my @arr1 = $arr1.words>>.Int;
my @arr2 = $arr2.words>>.Int;

die "Non integer value(s) in arr1" unless all(@arr1) ~~ Int;
die "Non integer value(s) in arr2" unless all(@arr2) ~~ Int;

say ((@arr1.max - @arr2.min).abs,
     (@arr2.max - @arr1.min).abs).max;
