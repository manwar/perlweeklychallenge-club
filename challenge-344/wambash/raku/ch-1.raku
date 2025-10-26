#!/usr/bin/env raku

sub array-form-compute (+ints,:$x) {
    ints
    andthen [~] |$_
    andthen $_ + $x
    andthen .comb
}

multi MAIN (Bool :test($)!) {
    use Test;
    is array-form-compute([1, 2, 3, 4], :12x), [1, 2, 4, 6], 'tests addition of 1234 and 12';
    is array-form-compute([1, 2, 0, 0], :34x), [1, 2, 3, 4], 'tests addition with trailing zeros';
    is array-form-compute([2, 7, 4], :181x), [4, 5, 5], 'tests addition with carry propagation';
    is array-form-compute([9, 9, 9], :1x), [1, 0, 0, 0], 'tests addition causing digit overflow';
    is array-form-compute([0], :1000x), [1, 0, 0, 0], 'tests addition when input is zero';
    is array-form-compute([1, 0, 0, 0, 0], :9999x), [1, 9, 9, 9, 9], 'tests addition with large x';
    is array-form-compute([1], :999x), [1, 0, 0, 0], 'tests single-digit input with large addition';
    done-testing;
}

multi MAIN (+ints,:$x) {
    put array-form-compute ints,:$x;
}
