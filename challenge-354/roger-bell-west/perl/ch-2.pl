#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]], 'example 1');
is_deeply(shiftgrid([[10, 20], [30, 40]], 1), [[40, 10], [20, 30]], 'example 2');
is_deeply(shiftgrid([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]], 'example 3');
is_deeply(shiftgrid([[1, 2, 3], [4, 5, 6]], 5), [[2, 3, 4], [5, 6, 1]], 'example 4');
is_deeply(shiftgrid([[1, 2, 3, 4]], 1), [[4, 1, 2, 3]], 'example 5');

use List::MoreUtils qw(natatime);

sub shiftgrid($gi, $k0) {
  my @wi;
  foreach my $x (@{$gi}) {
    push @wi, @{$x};
  }
  my $k = $k0 % scalar @wi;
  my @wo = @wi[scalar @wi - $k .. $#wi];
  push @wo, @wi[0 .. scalar @wi - $k - 1];
  my @go;
  my $it = natatime scalar @{$gi->[0]}, @wo;
  while (my @x = $it->()) {
    push @go, \@x;
  }
  \@go;
}
