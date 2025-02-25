#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations(2).map({ hamming-distance(|$_) }).sum;

sub hamming-distance(UInt:D \a, UInt:D \b --> UInt:D) {
    my \sz = [a, b].max.log2.floor + 1;
    (a.fmt("\%0{sz}b").comb «-» b.fmt("\%0{sz}b").comb)».abs.sum
}
