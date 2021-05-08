#!/usr/bin/env raku

sub search-matrix ( $n, @matrix ) {
    @matrix
    andthen .first: $n ≤ *.tail
    andthen .first: { $n == $_ }
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @matrix =
    [  1,  2,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ],
    ;

    nok search-matrix(35, @matrix);
    is  search-matrix(39, @matrix), 39;
    done-testing;
}
