#!/usr/bin/env raku

sub smallest-positive-number(+@n) {
    1..*
    andthen .first: * == @n.none
}

multi MAIN (:$test!) {
    use Test;
    is smallest-positive-number(5, 2, -2, 0),1;
    is smallest-positive-number(1, 8, -1),2;
    is smallest-positive-number(2, 0, -1),1;
    done-testing;
}

multi MAIN(**@n) {
    say smallest-positive-number @n
}
