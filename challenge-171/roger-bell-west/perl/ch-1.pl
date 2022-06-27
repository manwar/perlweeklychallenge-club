#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Math::Prime::Util qw(divisor_sum);

use Test::More tests => 1;

is_deeply(oddabundant(20),
          [945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
           6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505,
           8925],
          'example 1');

sub oddabundant($ct) {
  my $n = 1;
  my @o;
  while (1) {
    if (divisor_sum($n) > $n * 2) {
      push @o,$n;
      if (scalar @o >= $ct) {
        last;
      }
    }
    $n += 2;
  }
  return \@o;
}
