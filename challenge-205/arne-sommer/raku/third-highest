#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems >= 2 && all(@array) ~~ /^<[0..9]>*$/, :v($verbose));

my @unique = @array.sort.squish.reverse;

say ": Sorted Unique: { @unique.join(", ") }" if $verbose;

say @unique.elems >= 3 ?? @unique[2] !! @unique[0];
