#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(findkbeauty(240, 2), 2, 'example 1');
is(findkbeauty(1020, 2), 3, 'example 2');
is(findkbeauty(444, 2), 0, 'example 3');
is(findkbeauty(17, 2), 1, 'example 4');
is(findkbeauty(123, 1), 2, 'example 5');

sub findkbeauty($a, $n) {
  my $total = 0;
  my @c = split '', $a;
  foreach my $ti (0 .. (scalar @c) - $n) {
    my $tn = join('', @c[$ti .. $ti + $n - 1]);
    if ($a % $tn == 0) {
      $total += 1;
    }
  }
  $total;
}
