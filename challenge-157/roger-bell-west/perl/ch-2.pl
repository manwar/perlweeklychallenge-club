#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(brazilian(7),
   1,
   'example 1');

is(brazilian(6),
   0,
   'example 2');

is(brazilian(8),
   1,
   'example 3');

sub brazilian {
  my $n=shift;
  foreach my $b (2..$n-2) {
    my $nn = $n;
    my $braz = 1;
    my $digit = $nn % $b;
    while ($nn > 0) {
      if ($digit == $nn % $b) {
        $nn = int($nn/$b);
      } else {
        $braz = 0;
        last;
      }
    }
    if ($braz) {
      return 1;
    }
  }
  return 0;
}
