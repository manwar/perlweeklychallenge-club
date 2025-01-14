#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(arrangebinary([1, 0, 0, 0, 1], 1), 1, 'example 1');
is(arrangebinary([1, 0, 0, 0, 1], 2), 0, 'example 2');

sub arrangebinary($a, $n) {
  my @b = @{$a};
  my $t = $n;
  foreach my $i (0 .. $#b) {
    if ($b[$i] == 0 &&
        ($i == 0 || $b[$i - 1] == 0) &&
        ($i == $#b || $b[$i + 1] == 0)) {
      $b[$i] = 1;
      $t -= 1;
      if ($t == 0) {
        last;
      }
    }
  }
  ($t == 0)?1:0;
}
