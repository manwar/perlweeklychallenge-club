#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, :v($verbose));

my $bin = $N.fmt('%b');

say ": $bin (binary)\n: { $bin.flip } (binary flipped)" if $verbose;

say + ($bin eq $bin.flip);