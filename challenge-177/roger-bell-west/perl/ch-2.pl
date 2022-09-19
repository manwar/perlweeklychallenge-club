#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(ppc(20),
          [101, 16061, 31013, 35053, 38083, 73037, 74047, 91019,
           94049, 1120211, 1150511, 1160611, 1180811, 1190911,
           1250521, 1280821, 1360631, 1390931, 1490941, 1520251],
          'example 1');

use Math::Prime::Util qw(is_prime);

sub ppc($ct) {
  my @o;
  my $fh = 0;
  while (scalar @o < $ct) {
    $fh++;
    if ($fh =~ /0/) {
      next;
    }
    my $c = $fh . '0' . reverse($fh);
    if (is_prime($c)) {
      push @o,$c;
      if (scalar @o >= $ct) {
        last;
      }
    }
  }
  return \@o;
}
