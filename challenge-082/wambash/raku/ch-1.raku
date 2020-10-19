#!/usr/bin/env raku

sub common-factors( +@a ) {
    my $gcd = [gcd] @a;
    1, 2 ... $gcd
    andthen .grep:  $gcd %% *
}

multi MAIN ( +@a ) {
    say  common-factors @a;
}

multi MAIN (Bool :$test!) {
    use Test;
    is common-factors(12, 18), (1,2,3,6);
    is common-factors(18, 23), (1);
    is common-factors(6, 9, 15), (1,3);
    done-testing
}
