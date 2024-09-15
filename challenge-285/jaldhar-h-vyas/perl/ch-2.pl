#!/usr/bin/perl
use v5.38;
no warnings qw/ recursion /;
use constant PENNY => 1;
use constant NICKEL => 5;
use constant DIME => 10;
use constant QUARTER => 25;
use constant HALFDOLLAR => 50;

sub changeCombinations($amount, $largestCoin){
    state @coins=(PENNY, NICKEL, DIME, QUARTER, HALFDOLLAR);
    if ($largestCoin > $amount) {
        return 0;
    }

    if ($largestCoin == $amount) {
        return 1;
    }

    my $total;

    for my $coin (grep {$_ <= $largestCoin} @coins) {
        $total += changeCombinations($amount - $largestCoin, $coin);
    }

    return $total;
}

my ($amount) = @ARGV;
my $largestCoin = HALFDOLLAR;

say changeCombinations($amount + $largestCoin, $largestCoin)
