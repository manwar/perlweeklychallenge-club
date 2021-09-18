#!/usr/bin/env raku

sub odd-number (+@n) {
    @n
    andthen .Bag
    andthen .first: *.value !%% 2
    andthen .key
}

multi MAIN (*@n) {
    say odd-number @n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is odd-number(2, 5, 4, 4, 5, 5, 2), 5;
    is odd-number(1, 2, 3, 4, 3, 2, 1, 4, 4), 4;
    done-testing;
}
