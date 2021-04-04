#! /usr/bin/env raku

unit sub MAIN (Int $N where $N != 0, Int $D where $D != 0);

my $rat = $N / $D;

my ($base, $rep) = $rat.base-repeating;

say $base, ( $rep ?? "($rep)" !! '' );