#! /usr/bin/env raku

unit sub MAIN ($array_1, $array_2,
               :v(:$verbose));

my @array_1 = $array_1.words;
my @array_2 = $array_2.words;

die "Array1: Non-negative integers only" unless all(@array_1) ~~ /^<[0..9]>+$/;
die "Array2: Non-negative integers only" unless all(@array_2) ~~ /^<[0..9]>+$/;

my @common = @array_1 (&) @array_2;

say ": Common: { @common>>.key.sort.join(",")}" if $verbose;

say @common ?? @common>>.key.sort.first !! -1;