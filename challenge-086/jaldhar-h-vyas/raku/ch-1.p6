#!/usr/bin/perl6

sub MAIN (
    $A,  #= difference between any pair from <N>
    *@N  #= array of integers
) {
    say @N.combinations(2).grep({ @_.max - @_.min == $A }).elems ?? 1 !! 0;
}