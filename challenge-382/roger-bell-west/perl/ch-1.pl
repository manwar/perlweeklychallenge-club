#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;
use Test::Deep::NoTest;
use Storable qw(dclone);

sub isqrt {
  my $n=shift;
  my $k=$n>>1;
  my $x=1;
  while ($x) {
    my $k1=($k+$n/$k) >> 1;
    if ($k1 >= $k) {
      $x=0;
    }
    $k=$k1;
  }
  return $k;
}

sub is_adjacentsquared($param, $hc) {
  my @hc = @{$hc};
  my @hcs = sort {$a <=> $b} @hc;
  unless (eq_deeply([1 .. $param], \@hcs)) {
    return 0;
  }
  foreach my $i (0 .. $param - 2) {
    my $pn = $hc[$i] + $hc[$i + 1];
    my $sn = isqrt($pn);
    if ($pn != $sn * $sn) {
      return 0;
    }
  }
  my $pn = $hc[0] + $hc[-1];
  my $sn = isqrt($pn);
  if ($pn != $sn * $sn) {
    return 0;
  }
  1;
}

is_deeply(is_adjacentsquared(32, hamiltoniancycle(32)), 1, 'example 1');
is_deeply(hamiltoniancycle(15), [], 'example 2');
is_deeply(is_adjacentsquared(34, hamiltoniancycle(34)), 1, 'example 3');
          
sub hamiltoniancycle($a) {
  if ($a < 31) {
    return [];
  }
  my %perfectsquares = map {$_ * $_ => 1} (1 .. $a);
  my %neighbours;
  foreach my $x (1 .. $a) {
    foreach my $y (keys %perfectsquares) {
      if ($y > $x) {
        my $z = $y - $x;
        if ($z <= $a) {
          $neighbours{$x}{$z} = 1;
          $neighbours{$z}{$x} = 1;
        }
      }
    }
  }
  my @stack;
  push @stack, [1];
  while (scalar @stack > 0) {
    my $lst = pop @stack;
    if (scalar @{$lst} == $a) {
      if (exists $perfectsquares{$lst->[0] + $lst->[-1]}) {
        return $lst;
      }
    } else {
      my %ls = map {$_ => 1} @{$lst};
      foreach my $candidate (keys %{$neighbours{$lst->[-1]}}) {
        unless (exists $ls{$candidate}) {
          my @nlst = @{dclone($lst)};
          push @nlst, $candidate;
          push @stack, \@nlst;
        }
      }
    }
  }
  [];
}
