#!/usr/bin/env raku

sub magic-number (@x, @y) {
    @y.min - @x.min
}

multi MAIN (Bool :test($)!) {
    use Test;
    is magic-number((3,7,5),(5,9,7)),2;
    is magic-number((1,2,1),(5,4,4)),3;
    is magic-number((2,),(5,)),3;
    done-testing;
}

multi MAIN ($x, $y) {
    say magic-number $x.comb(/'-'? \d+/), $y.comb(/'-'? \d+/)
}
