#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(sdn(3),[1210, 2020, 21200],'example 1');

sub sdn {
  my $count=shift;
  my @r;
  my $n=10;
  while (scalar @r < $count) {
    my @ns=map {$_+0} split '',sprintf('%d',$n);
    my @d=(0) x 10;
    map {$d[$_]++} @ns;
    my $sd=1;
    foreach my $i (0..$#ns) {
      if ($d[$i] != $ns[$i]) {
        $sd=0;
        last;
      }
    }
    if ($sd && $#ns<9) {
      foreach my $i ($#ns+1..9) {
        if ($d[$i] != 0) {
          $sd=0;
          last;
        }
      }
    }
    if ($sd) {
      push @r,$n;
    }
    $n+=10;
  }
  return \@r;
}

