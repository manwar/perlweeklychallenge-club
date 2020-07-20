#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(gray(4),
          [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8],
          'example 1',
            );

sub gray {
  my $depth=shift;
  my @s=(0,1);
  if ($depth>1) {
    my $k=1;
    foreach (2..$depth) {
      $k*=2;
      my @o=@s;
      push @o,map {$_ | $k} reverse @s;
      @s=@o;
    }
  }
  return \@s;
}
