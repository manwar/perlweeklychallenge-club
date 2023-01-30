#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

sub sevensegment($l) {
  my @disp = (0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67);
  my @v;
  if ($l == 0) {
    push @v, 0;
  } else {
    my $ll = $l;
    while ($ll > 0) {
      push @v, $ll % 10;
      $ll = int($ll/10);
    }
    @v = reverse @v;
  }
  my @d;
  foreach (1..7) {
    push @d, [(" ") x (6 * scalar @v)];
  }
  while (my ($i, $vv) = each @v) {
    my $x = 6 * $i;
    my $da = $disp[$vv];
    if (($da & 1) > 0) {
      foreach my $xa ($x + 1..$x + 3) {
        $d[0][$xa] = '#';
      }
    }
    if (($da & 2) > 0) {
      foreach my $y (1..2) {
        $d[$y][$x + 4] = '#';
      }
    }
    if (($da & 4) > 0) {
      foreach my $y (4..5) {
        $d[$y][$x + 4] = '#';
      }
    }
    if (($da & 8) > 0) {
      foreach my $xa ($x + 1..$x + 3) {
        $d[6][$xa] = '#';
      }
    }
    if (($da & 16) > 0) {
      foreach my $y (4..5) {
        $d[$y][$x] = '#';
      }
    }
    if (($da & 32) > 0) {
      foreach my $y (1..2) {
        $d[$y][$x] = '#';
      }
    }
    if (($da & 64) > 0) {
      foreach my $xa ($x + 1..$x + 3) {
        $d[3][$xa] = '#';
      }
    }
  }
    foreach my $r (@d) {
      print join('', @{$r}),"\n";
    }
  }

sevensegment(1234567890);
sevensegment(200);
