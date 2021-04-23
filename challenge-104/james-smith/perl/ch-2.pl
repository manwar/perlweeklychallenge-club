#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## This simulates a game with random selects....
simulate() foreach 1..10;
## This simulates a game where player 1 takes a random number of token(s)
## Then player to takes the optimal number of tokens... to guarentee a win...
simulate_player2() foreach 1..10;

sub simulate_player2 {
  my $tokens = 12;
  while(1) {
    my $n = 1 + int rand 3;
    $tokens -= $n;
    say "Player 1 takes $n token(s) and leaves $tokens token(s)";
    $n = 4-$n;
    print "Player 2 takes $n token(s) and ";
    $tokens -= $n;
    last unless $tokens;
    say "leaves $tokens tokens";
  }
  say "wins...\n";
}

sub simulate {
  my($tokens,$player,$n) = (12,1,'');
  while(1) {
    $n = 1 + int rand 3;
    last if $n >= $tokens;
    $tokens-=$n;
    say "Player $player takes $n token(s) and leaves $tokens token(s)";
    $player = 3-$player;
  }
  say "Player $player takes the last $n token(s) and wins...\n";
}

