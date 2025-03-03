#!/usr/bin/env raku

sub array-intersection (+list) {
    [∩] list
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply array-intersection([1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]), set(1,4);
    is array-intersection([1, 0, 2, 3], [2,4, 5]), (2,);
    is array-intersection([1,  2, 3], [4, 5], [6,]), ();
    done-testing;
}

multi MAIN (+list) {
    put array-intersection list».comb(/\w+/)
}
