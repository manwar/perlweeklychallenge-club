#!/usr/bin/env raku

sub number-placement (+@numbers, :$count) {
    @numbers.join
    andthen .match: / [^||0] <( 0 <?before (0|$) > /,:g #)> close bracket for emacs
    andthen $count ≤ .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    plan 4;
    is number-placement(1,0,0,0,1,:1count),True;
    is number-placement(1,0,0,0,1,:2count),False;
    is number-placement(1,0,0,0,0,0,0,1,:3count),False;
    is number-placement(1,0,0,0,0,0,0,0,1,:3count),True;
    done-testing;
}

multi MAIN (*@numbers, :$count) {
    say +number-placement @numbers, :$count
}
