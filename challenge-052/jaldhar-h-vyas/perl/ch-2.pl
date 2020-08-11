#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub sum {
    my $total = 0;
    for my $elem (@{ $_[0] }) {
        $total += $elem;
    }

    return $total;
}

sub minmax {
    my @coins = @{ $_[0] };

    return sum(\@coins[1 .. -1]) > sum(\@coins[0 .. -2]);
}

sub run {
    my ($playerTurn) = @_;
    my @coins = (100, 50, 1, 10, 5, 20, 200, 2);
    my $playerAmount = 0;
    my $computerAmount = 0;

    while (scalar @coins) {
        my $amount = minmax(\@coins) ? shift @coins : pop @coins;

        if ($playerTurn) {
            $playerAmount += $amount;
            $playerTurn = undef;
        } else {
            $computerAmount += $amount;
            $playerTurn = 1;
        }
    }

    if ($playerAmount > $computerAmount) {
        return (1, $playerAmount / 100);
    } else {
        return (undef, $computerAmount / 100);
    }
}

say 'Assuming both take the best coin...';
for my $playerTurn (1, undef) {
    print 'If the ', ($playerTurn ? 'player' : 'computer'), ' goes first, ';
    my ($winner, $amount) = run($playerTurn);
    print 'the ', ($winner ? 'player' : 'computer'), ' wins with £',
        $amount, ".\n";
}