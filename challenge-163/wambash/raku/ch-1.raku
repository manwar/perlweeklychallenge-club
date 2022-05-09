#!/usr/bin/env raku

sub sum-bitwise-operator (+@n) {
    @n.combinations(2)
    andthen .map: { [+&] $_ }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sum-bitwise-operator(1,2,3), 3;
    is sum-bitwise-operator(2,3,4), 2;
    done-testing;
}

multi MAIN (*@n) {
    say sum-bitwise-operator @n
}
