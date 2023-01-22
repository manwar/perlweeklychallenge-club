#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(arithmeticslices([1, 2, 3, 4]), [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], 'example 1');
is_deeply(arithmeticslices([2]), [], 'example 2');

sub arithmeticslices($l) {
  my @o;
  if (scalar @{$l} >= 3) {
    foreach my $a (0..(scalar @{$l} - 3)) {
      my $valid = 0;
      foreach my $b ($a + 2..(scalar @{$l} - 1)) {
        my @v = @{$l}[$a..$b];
        unless ($valid) {
          foreach my $i (0..(scalar @v - 3)) {
            if ($v[$i + 1] - $v[$i] == $v[$i + 2] - $v[$i + 1]) {
              $valid = 1;
              last;
            }
          }
        }
        if ($valid) {
          push @o, \@v;
        }
      }
    }
  }
  return \@o;
}
