#!/bin/env raku

my @A = <10 20 30 40 50>;
my @B = <3 4>;
@A.rotate($_).say for @B;

say '=' x 16;

@A = <7 4 2 6 3>;
@B = <1 3 4>;
@A.rotate($_).say for @B;
