#!/usr/bin/raku

constant PENNY = 1;
constant NICKEL = 5;
constant DIME = 10;
constant QUARTER = 25;
constant HALFDOLLAR = 50;

sub changeCombinations($amount, $largestCoin){
    constant @coins = (HALFDOLLAR, QUARTER, DIME, NICKEL, PENNY);

    if $largestCoin > $amount {
        return 0;
    }

    if $largestCoin == $amount {
        return 1;
    }

    my $total;

    for @coins.grep({ $_ <= $largestCoin }) -> $coin {
        $total += changeCombinations($amount - $largestCoin, $coin);
    }

    return $total;
}

sub MAIN(
    Int $amount
) {
    say changeCombinations($amount + HALFDOLLAR, HALFDOLLAR);
}