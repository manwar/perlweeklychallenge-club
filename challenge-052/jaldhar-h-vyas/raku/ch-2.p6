#!/usr/bin/perl6

sub minmax(@coins) {
    return [+] @coins[1 .. *-1] > [+] @coins[0 .. *-2];
}

sub run(Bool $playerTurn_) {
    my $playerTurn = $playerTurn_;
    my @coins = (100, 50, 1, 10, 5, 20, 200, 2);
    my $playerAmount = 0;
    my $computerAmount = 0;

    while @coins.elems {
        my $amount = minmax(@coins) ?? @coins.shift !! @coins.pop;

        if ($playerTurn) {
            $playerAmount += $amount;
            $playerTurn = False;
        } else {
            $computerAmount += $amount;
            $playerTurn = True;
        }
    }

    if ($playerAmount > $computerAmount) {
        return (True, $playerAmount / 100);
    } else {
        return (False, $computerAmount / 100);
    }
}

multi sub MAIN() {
    say 'Assuming both take the best coin...';
    for (True, False) -> $playerTurn {
        print 'If the ', ($playerTurn ?? 'player' !! 'computer'),
            ' goes first, ';
        my ($winner, $amount) = run($playerTurn);
        print 'the ', ($winner ?? 'player' !! 'computer'), ' wins with £',
            $amount, ".\n";
    }
}