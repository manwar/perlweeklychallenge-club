#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $M = 100) {
   (2 .. $M).grep({$_.is-prime && $_.comb.sum.is-prime}).join(', ').put;
}
