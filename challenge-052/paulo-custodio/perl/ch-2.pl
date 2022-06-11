#!/usr/bin/env perl

# Challenge 052
#
# TASK #2
# Lucky Winner
# Suppose there are following coins arranged on a table in a line in random
# order.
#
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
#
# Suppose you are playing against the computer. Player can only pick one coin
# at a time from either ends. Find out the lucky winner, who has the larger
# amounts in total?

use Modern::Perl;
use List::Util qw( shuffle );
local $|=1;

my @coins = shuffle(100, 50, 1, 10, 5, 20, 200, 2);

my $human = 0;
my $computer = 0;

while (@coins) {
    # human
    print "Coins: @coins. draw (b/e)? ";
    my $draw = "";
    while ($draw ne 'b' && $draw ne 'e') {
        chomp($draw = <>);
    }
    if ($draw eq 'b') {
        $human += shift(@coins);
    }
    else {
        $human += pop(@coins);
    }

    # computer
    if ($coins[0] >= $coins[-1]) {
        $computer += shift(@coins);
    }
    else {
        $computer += pop(@coins);
    }
}

if ($human > $computer) {
    say "You WIN ($human/$computer)";
}
else {
    say "You LOOSE ($human/$computer)";
}
