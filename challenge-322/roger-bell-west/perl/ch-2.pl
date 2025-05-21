#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(rankarray([55, 22, 44, 33]), [4, 1, 3, 2], 'example 1');
is_deeply(rankarray([10, 10, 10]), [1, 1, 1], 'example 2');
is_deeply(rankarray([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2], 'example 3');

sub rankarray($a) {
  my @b = sort {$::a <=> $::b} keys %{{map {$_ => 1} @{$a}}};
  my %c;
  while (my ($i, $n) = each @b) {
    $c{$n} = $i + 1;
  }
  my @out;
  foreach my $v (@{$a}) {
    push @out, $c{$v};
  }
  \@out;
}
