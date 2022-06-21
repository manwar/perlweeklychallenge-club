#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;
use Math::Prime::Util qw(next_prime);

is_deeply(primorial(5),
          [1, 2, 6, 30, 210],
          'example 1');

is_deeply(primorial(10),
          [1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870],
          'example 2');

sub nthprimelimit {
  my $n=shift;
  my $m=15;
  if ($n >= 6) {
    $m=int(1+$n*log($n*log($n)));
  }
  return $m;
}

sub primorial($ct) {
  my @o = (1);
  my $lp = 1;
  while (scalar @o < $ct) {
    $lp = next_prime($lp);
    push @o,$o[-1] * $lp;
  }
  return \@o;
}
