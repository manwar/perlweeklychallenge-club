#!/bin/env raku

unit sub MAIN(Rat:D \r);

put "parent: {r.&parent.&toStr} " ~
    "grandparent: {r.&parent.&parent.&toStr}";

my method parent(Rat:D \r : --> Rat:D) {
    r < 1 ??
        r.numerator/(r.denominator - r.numerator) !!
        (r.numerator - r.denominator)/r.denominator
}

my method toStr(Rat:D \r : --> Str:D) {
    "{r.numerator}/{r.denominator}"
}
