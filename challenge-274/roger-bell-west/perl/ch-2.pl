#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(busroute([[12, 11, 41], [15, 5, 35]]), [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47], 'example 1');
is_deeply(busroute([[12, 3, 41], [15, 9, 35], [30, 5, 25]]), [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59], 'example 2');

use List::Util qw(min);

sub busroute($a) {
  my @routes;
  foreach my $rt (@{$a}) {
    my %ri;
    my ($interval, $offset, $duration) = @{$rt};
    my $start = $offset;
    while ($start <= 60 + $offset) {
      $ri{$start} = $start + $duration;
      $start += $interval;
    }
    push @routes, \%ri;
  }
  my @out;
  foreach my $t (0 .. 59) {
    my %best;
    my $at = -1;
    my %nxt;
    my $ndt = -1;
    values @routes;
    while (my ($i, $r) = each @routes) {
      my $nb = min grep {$_ >= $t} keys(%{$r});
      my $nt = $r->{$nb};
      if ($at == -1 || $nt < $at) {
        %best = ();
        $at = $nt;
      }
      if ($nt <= $at) {
        $best{$i} = 1;
      }
      if ($ndt == -1 || $nb < $ndt) {
        %nxt = ();
        $ndt = $nb;
      }
      if ($nb <= $ndt) {
        $nxt{$i} = 1;
      }
    }
    my @intersect = grep {exists $nxt{$_}} keys %best;
    if (scalar @intersect == 0) {
      push @out, $t;
    }
  }
  return \@out;
}
