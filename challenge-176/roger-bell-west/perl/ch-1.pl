#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is(permutable(), 142857, 'example 1');

sub permutable {
  my $n = 0;
  while (1) {
    $n++;
    my $base = join('',sort(split('',$n)));
    my $q = 1;
    foreach my $k (2..6) {
      if (join('',sort(split('',$n*$k))) ne $base) {
        $q = 0;
        last;
      }
    }
    if ($q) {
      return $n;
    }
  }
}
