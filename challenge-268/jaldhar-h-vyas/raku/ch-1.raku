#!/usr/bin/raku

sub MAIN(
    $x,
    $y
) {
    my @diff = $x.words.sort Z- $y.words.sort;

    say @diff.all ?? @diff[0].abs !! "no magic number";
}