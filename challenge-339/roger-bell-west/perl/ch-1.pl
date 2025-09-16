#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxdiff([5, 9, 3, 4, 6]), 42, 'example 1');
is(maxdiff([1, -2, 3, -4]), 10, 'example 2');
is(maxdiff([-3, -1, -2, -4]), 10, 'example 3');
is(maxdiff([10, 2, 0, 5, 1]), 50, 'example 4');
is(maxdiff([7, 8, 9, 10, 10]), 44, 'example 5');

use List::Util qw(max);
sub maxdiff($a) {
  my $md = 0;
  foreach my $w (0 .. scalar @{$a} - 2) {
    foreach my $x ($w + 1 .. scalar @{$a} - 1) {
      foreach my $y ($w + 1 .. scalar @{$a} - 2) {
        if ($y != $x) {
          foreach my $z ($y + 1 .. scalar @{$a} - 1) {
            if ($z != $x) {
              my $v = abs($a->[$w] * $a->[$x] - $a->[$y] * $a->[$z]);
              $md = max($md, $v);
            }
          }
        }
      }
    }
  }
  $md;
}
