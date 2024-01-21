#!/usr/bin/env raku
use Prime::Factor;

sub specal-numbers (+@ints) {
    my $size = @ints.elems;

    1..* Z=> @ints
    andthen .grep:  $size %% *.key
    andthen .map: *.value²
    andthen .sum
}

sub specal-numbers-pf (+@ints) {
    @ints
    andthen .elems
    andthen divisors $_
    andthen .map: *-1
    andthen @ints[|$_]
    andthen .map: *²
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is specal-numbers(1..4),21;
    is specal-numbers(2, 7, 1, 19, 18, 3),63;
    is specal-numbers-pf(1..4),21;
    is specal-numbers-pf(2, 7, 1, 19, 18, 3),63;
    done-testing;
}

multi MAIN (+@ints) {
    say specal-numbers @ints
}
