#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(
  reordernotes('Mozart', ['C', 'D', 'E', 'F', 'G', 'A', 'B'], [7, 1, 6, 2, 5, 3, 4]),
  \{ Mozart => ['D', 'F', 'A', 'B', 'G', 'E', 'C'] },
  'example 1'
    );
is_deeply(reordernotes('Chopin', ['C', 'C#', 'D', 'D#', 'E', 'F'], [6, 5, 4, 3, 2, 1]), \{ 'Chopin' => ['F', 'E', 'D#', 'D', 'C#', 'C'] }, 'example 2');
is_deeply(reordernotes('Vivaldi', ['A', 'B', 'C', 'D', 'E'], [1, 2, 3, 4, 5]), \{ 'Vivaldi' => ['A', 'B', 'C', 'D', 'E'] }, 'example 3');
is_deeply(reordernotes('Debussy', ['C', 'D', 'F', 'G', 'A'], [1, 3, 5, 2, 4]), \{ 'Debussy' => ['C', 'G', 'D', 'A', 'F'] }, 'example 4');
is_deeply(reordernotes('Stravinsky', ['C#'], [1]), \{ 'Stravinsky' => ['C#'] }, 'example 5');

sub reordernotes($composer, $notes, $order) {
  my @out = ("") x scalar @{$order};
  while (my ($i, $n) = each @{$order}) {
    $out[$n - 1] = $notes->[$i];
  }
  \{$composer => \@out};
}
