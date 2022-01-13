#!/bin/env raku

sub MAIN(UInt:D \i, UInt:D \j, UInt:D \k) {
    put ((1..i)X(1..j)).map({.[0]*.[1]}).sort[k-1];
}
