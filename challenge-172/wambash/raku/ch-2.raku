#!/usr/bin/env raku

sub quantile ($q,+@n) {
    my $p = @n.end * $q;
    (1-$q)*@n[$p.floor] + $q*@n[$p.ceiling]
}

sub five-number-summary (+@n) {
    0, 1/4 ... 1
    andthen .map: *.&quantile: @n.sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is five-number-summary(0,4),(0,1,2,3,4);
    is five-number-summary(6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49),(6,20.25,40,42.75,49);
    is five-number-summary(0,1),(0,1/4 ... 1);
    is five-number-summary(0,2,4),(0,1/2,2,3+1/2,4);
    is five-number-summary(0,1,2,3,4),(0,1,2,3,4);
    done-testing;
}

multi MAIN (*@n) {
    say five-number-summary @n
}
