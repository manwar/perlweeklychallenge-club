#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

use Test::More tests => 1;

is_deeply(reversible(99),
          [ 10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41,
            43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90 ],
          'example 1');

sub reversible($mx) {
  my @o;
  foreach my $n (1..$mx) {
    my $t = $n + reverse($n);
    my $q = 1;
    while ($t > 0) {
      if ($t % 2 == 0) {
        $q = 0;
        last;
      }
      $t = int($t/10);
    }
    if ($q) {
      push @o,$n;
    }
  }
  return \@o;
}
