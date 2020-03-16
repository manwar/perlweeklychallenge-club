#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @coins = qw[£1 50p 1p 10p 5p 20p £2 2p];
my @amts  = map { coin2amt($_) } @coins;

my ($player1, $player2);
my $turn = 1;

while (@amts) {
  if ($turn %2) {
    say "Player 1 ...";
    $player1 += pick_coin(\@amts);
    say "... has ", amt2coins($player1);
  } else {
    say "Player 2 ...";
    $player2 += pick_coin(\@amts);
    say "... has ", amt2coins($player2);
  }
  $turn++;
}

say "Player one has: ", amt2coins($player1);
say "Player two has: ", amt2coins($player2);

sub pick_coin {
  my ($remaining) = @_;

  if ($remaining->[0] > $remaining->[-1]) {
    say "... takes ", amt2coins($remaining->[0]);
    return shift @$remaining;
  } else {
    say "... takes ", amt2coins($remaining->[-1]);
    return pop @$remaining;
  }
}

sub coin2amt {
  $_[0] =~ s/p$//;
  $_[0] =~ s/£(\d+)/100*$1/e;

 return $_[0];
}

sub amt2coins {
  return $_[0] < 100 ? "$_[0]p" : '£' . $_[0]/100;
}
