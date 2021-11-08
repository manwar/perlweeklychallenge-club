#!/usr/bin/env raku


sub integer-square-root ($n) {
    $n
    andthen ^∞ .toggle: *² ≤ $n
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is integer-square-root(10),3;
    is integer-square-root(27),5;
    is integer-square-root(85),9;
    is integer-square-root(101),10;
    done-testing
}
