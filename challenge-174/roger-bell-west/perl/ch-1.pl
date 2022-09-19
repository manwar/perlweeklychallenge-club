#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(disarium(19),
          [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676,
            2427, 2646798 ],
          'example 1');

sub disarium($ct) {
  my @o;
  my @pows=([(1) x 10]);
  my $c = 0;
  while (1) {
    my $disar = 0;
    if ($c > 0) {
      my $ca = $c;
      my @cl;
      my $tx = 0;
      while ($ca > 0) {
        $tx++;
        push @cl,$ca % 10;
        $ca = int($ca/10);
      }
      @cl = reverse @cl;
      if ($tx >= scalar @pows) {
        foreach my $power ((scalar @pows)..$tx) {
          my @row;
          foreach my $digit (0..9) {
            push @row,$pows[$power-1][$digit] * $digit
          }
          push @pows,\@row;
        }
      }
      foreach my $i (0..$#cl) {
        $disar += $pows[$i+1][$cl[$i]];
      }
    }
    if ($disar == $c) {
      push @o,$c;
      if (scalar @o >= $ct) {
        last;
      }
    }
    $c++;
  }
  return \@o;
}
