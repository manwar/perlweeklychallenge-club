#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(shortestroute([[1, 2, 6], [5, 6, 7]], 1, 7), [1, 2, 6, 7], 'example 1');
is_deeply(shortestroute([[1, 2, 3], [4, 5, 6]], 2, 5), [], 'example 2');
is_deeply(shortestroute([[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]], 1, 7), [1, 2, 3, 8, 7], 'example 3'); 

sub shortestroute($r0, $origin, $destination) {
  my %r;
  foreach my $rt (@{$r0}) {
    foreach my $i (0..$#{$rt}-1) {
      my $ri = $rt->[$i];
      my $rj = $rt->[$i + 1];
      $r{$ri}{$rj} = 1;
      $r{$rj}{$ri} = 1;
    }
  }
  my $out = [];
  my @stack = ([$origin]);
  while (scalar @stack > 0) {
    my $s = shift @stack;
    my $l = $s->[-1];
    if ($l == $destination) {
      $out = $s;
      last;
    } else {
      my %s1 = map {$_ => 1} @{$s};
      foreach my $pd (grep {!exists $s1{$_}} keys %{$r{$l}}) {
        push @stack,[@{$s}, $pd];
      }
    }
  }
  return $out;
}
