#!/usr/bin/env raku

multi ugly-numbers ($n, :$ubounds!) {
    my @twos   = 1,2,4  ... $ubounds;
    my @threes = 1,3,9  ... $ubounds;
    my @fives  = 1,5,25 ... $ubounds;

    @twos X* @threes X* @fives
    andthen .sort
    andthen .[$n-1]
}

multi ugly-numbers ($n) {
    my $guess = ugly-numbers $n, ubounds => 5**($n**(1/3));

    ugly-numbers $n, ubounds => $guess;
}

multi MAIN ( $n ) {
    say ugly-numbers $n;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is ugly-numbers( 7),  8;
    is ugly-numbers(10), 12;
    is ugly-numbers(150, ubounds=> 5**(150**(1/3))), 5832;
    is ugly-numbers(150),                            5832;
    is ugly-numbers(2¹⁶), 2³³ * 3⁴⁹;
    done-testing;
}
