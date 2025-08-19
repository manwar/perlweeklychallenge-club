#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(findwinner([[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]), 'A', 'example 1');
is(findwinner([[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]), 'B', 'example 2');
is(findwinner([[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1], [0, 2], [2, 2]]), 'Draw', 'example 3');
is(findwinner([[0, 0], [1, 1]]), 'Pending', 'example 4');
is(findwinner([[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]), 'B', 'example 5');

sub findwinner($a) {
  my @board = (
    [ 0, 0, 0 ],
    [ 0, 0, 0 ],
    [ 0, 0, 0 ],
      );
  my $player = 1;
  foreach my $play (@{$a}) {
    $board[$play->[0]][$play->[1]] = $player;
    $player = 3 - $player;
  }
  foreach my $pattern (
    [0, 0, 1, 0],
    [0, 1, 1, 0],
    [0, 2, 1, 0],
    [0, 0, 0, 1],
    [1, 0, 0, 1],
    [2, 0, 0, 1],
    [0, 0, 1, 1],
    [0, 2, 1, -1],
      ) {
    my %cellvals;
    foreach my $i (0 .. 2) {
      my $x = $pattern->[0] + $i * $pattern->[2];
      my $y = $pattern->[1] + $i * $pattern->[3];
      $cellvals{$board[$y][$x]}++;
    }
    if (scalar keys %cellvals == 1) {
      my $winner = (keys %cellvals)[0];
      if ($winner == 1) {
        return "A";
      } elsif ($winner == 2) {
        return "B";
      }
    }
  }
  if (scalar @{$a} == 9) {
    return "Draw";
  } else {
    return "Pending";
  }
}
