#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(happy(8),[1, 7, 10, 13, 19, 23, 28, 31],'example 1');

sub ssd {
  my $n = shift;
  my $out = 0;
  while ($n > 0) {
    my $d = $n % 10;
    $out += $d * $d;
    $n = int($n/10);
  }
  return $out;
}

sub happy {
  my $ct = shift;
  my %hm = (1 => 1);
  my $c = 0;
  my @out;
  while (1) {
    $c++;
    unless (exists $hm{$c}) {
      my $v = $c;
      my %ss = ($v => 1);
      my $h = 1;
      while (1) {
        if (exists $hm{$v}) {
          $h = $hm{$v};
          last;
        } else {
          $v = ssd($v);
          if (exists $ss{$v}) {
            $h = 0;
            last;
          }
          $ss{$v}++;
        }
      }
      map {$hm{$_}=$h} keys %ss;
    }
    if ($hm{$c}) {
      push @out,$c;
      if (scalar @out >= $ct) {
        last;
      }
    }
  }
  return \@out;
}
