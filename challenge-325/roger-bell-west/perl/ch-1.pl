#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(consecutiveone([0, 1, 1, 0, 1, 1, 1]), 3, 'example 1');
is(consecutiveone([0, 0, 0, 0]), 0, 'example 2');
is(consecutiveone([1, 0, 1, 0, 1, 1]), 2, 'example 3');

use List::Util qw(max);

sub consecutiveone($a) {
  my %h = (0, 0);
  my $latch = 0;
  my $latched = 0;
  while (my ($i, $n) = each @{$a}) {
    if ($n == 1 && !$latched) {
      $latched = 1;
      $latch = $i;
    }
    if ($n == 0 && $latched) {
      $latched = 0;
      $h{$latch} = $i - $latch;
    }
  }
  if ($latched) {
    $h{$latch} = scalar @{$a} - $latch;
  }
  max(values(%h));
}
