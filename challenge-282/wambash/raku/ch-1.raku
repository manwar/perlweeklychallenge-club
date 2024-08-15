#!/usr/bin/env raku

sub good-integer ($int) {
    $int
    andthen .comb: / (\d) $0+ /
    andthen .first: *.chars == 3
}

multi MAIN (Bool :test($)!) {
    use Test;
    is good-integer(12344456), '444';
    is good-integer(1233334),    Nil;
    is good-integer(10020003), '000';
    done-testing;
}

multi MAIN ($int) {
    say good-integer( $int ) // -1;
}
