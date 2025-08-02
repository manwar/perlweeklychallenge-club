#!/usr/bin/env raku

#|( Given a even length list of integers print a list where you
    pick each adjacent pair (i, j) and replace it with j, i times.)
sub MAIN (
    *@a where (
        (@a.all ~~ Int)
        && (@a.elems %% 2)
        && (@a.rotor(1 => 1).map(*.Slip).all ~~ UInt)
    ) #= Even length list of Integers
) {
    @a.rotor(2).map( -> ($x, $y) { |($y xx $x) }).say
}
