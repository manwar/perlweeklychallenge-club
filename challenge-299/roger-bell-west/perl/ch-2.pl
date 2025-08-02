#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(wordsearch([['A', 'B', 'D', 'E'], ['C', 'B', 'C', 'A'], ['B', 'A', 'A', 'D'], ['D', 'B', 'B', 'C']], 'BDCA'), 1, 'example 1');
is(wordsearch([['A', 'A', 'B', 'B'], ['C', 'C', 'B', 'A'], ['C', 'A', 'A', 'A'], ['B', 'B', 'B', 'B']], 'ABAC'), 0, 'example 2');
is(wordsearch([['B', 'A', 'B', 'A'], ['C', 'C', 'C', 'C'], ['A', 'B', 'A', 'B'], ['B', 'B', 'A', 'A']], 'CCCAA'), 1, 'example 3');

sub encode($x, $y) {
    return $x * 64 + $y;
}

sub decode($z) {
    return [int($z / 64), $z % 64];
}

sub wordsearch($grid0, $word0) {
  my %grid;
  while (my ($y, $row) = each @{$grid0}) {
    while (my ($x, $c) = each @{$row}) {
      $grid{encode($x, $y)} = $c;
    }
  }
  my @word = split '', $word0;
  while (my ($start, $firstletter) = each %grid) {
    if ($firstletter eq $word[0]) {
      my @queue = ([$start]);
      while (scalar @queue > 0) {
        my @pos = @{shift @queue};
        if (scalar @pos == scalar @word) {
          return 1;
        } else {
          foreach my $dir ([0, 1], [1, 0], [0, -1], [-1, 0]) {
            my $lpos = decode($pos[-1]);
            my $npos = [$lpos->[0] + $dir->[0], $lpos->[1] + $dir->[1]];
            my $np = encode(@{$npos});
            my %posmap = map {$_ => 1} @pos;
            if (exists $grid{$np} &&
                !exists $posmap{$np} &&
                $grid{$np} eq $word[scalar @pos]) {
              push @queue, [@pos, $np];
            }
          }
        }
      }
    }
  }
  0;
}
