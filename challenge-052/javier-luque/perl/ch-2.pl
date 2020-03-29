#!/usr/bin/perl
# Test: ./ch-2.pl --optimal
use strict;
use warnings;
use Getopt::Long;
use feature qw /say/;

# Optimal flag
my $optimal = 0;
GetOptions ('optimal' => \$optimal);

# Some initialization variables
my @coins = (100, 50, 1, 10, 5, 20, 200, 2);
my $players = 2;
my $player_turn = 0;
my @totals = map { 0 } 1 .. $players;

# Play the game
while (scalar(@coins) > 0) {
    if ( ($optimal && $player_turn == 0) ||
          $coins[0] > $coins[-1] ) {
    	$totals[$player_turn] += shift @coins;
    } else {
    	$totals[$player_turn] += pop @coins;
    }

    # Next turn
    $player_turn = ($player_turn + 1) % $players;
}

# Display the scores
for my $i (1..$players) {
    say "Player $i total: " . $totals[$i - 1] . 'p';
}
