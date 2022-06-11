#!/usr/bin/env raku

sub farrey-sequence ($n) {
    1..$n
    andthen .combinations(2)
    andthen .map: { [/] $_ }\
    andthen 0/1,|.sort, 1/1
    andthen .squish
}

multi MAIN (Bool :test($)!) {
    use Test;
    is farrey-sequence(2), (0/1, 1/2, 1/1);
    is farrey-sequence(5), (0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1);
    is farrey-sequence(7), (0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1);
    is farrey-sequence(4), (0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1);
    done-testing;
}

multi MAIN (UInt $n) {
    farrey-sequence $n
    andthen .map: *.nude
    andthen .map: *.fmt: '%d','/'
    andthen .put
}
