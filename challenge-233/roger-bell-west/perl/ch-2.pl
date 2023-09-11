#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(frequencysort([1, 1, 2, 2, 2, 3]), [3, 1, 1, 2, 2, 2], 'example 1');
is_deeply(frequencysort([2, 3, 1, 3, 2]), [1, 3, 3, 2, 2], 'example 2');
is_deeply(frequencysort([-1, 1, -6, 4, 5, -6, 1, 4, 1]), [5, -1, 4, 4, -6, -6, 1, 1, 1], 'example 3');

sub frequencysort($al) {
  my %ct;
  foreach my $x (@{$al}) {
    $ct{$x}++;
  }
  my %rct;
  while (my ($k, $v) = each %ct) {
    $rct{$v} ||= [];
    push @{$rct{$v}}, $k;
  }
  my @out;
  foreach my $k (sort {$a <=> $b} keys %rct) {
    foreach my $v (sort {$b <=> $a} @{$rct{$k}}) {
      push @out, ($v) x $k;
    }
  }
  return \@out;
}
