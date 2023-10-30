#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(persistencearray([15, 99, 1, 34]), [1, 15, 34, 99], 'example 1');
is_deeply(persistencearray([50, 25, 33, 22]), [22, 33, 50, 25], 'example 2');

sub persistence($a) {
  my $steps = 0;
  my $b = $a;
  while ($b > 9) {
    $steps++;
    my $p = 1;
    while ($b > 0) {
      $p *= $b % 10;
      $b = int($b / 10);
    }
    $b = $p;
  }
  return $steps;
}

sub persistencearray($a) {
  my %c = map {$_ => persistence($_)} @{$a};
  return [sort {$c{$::a} <=> $c{$::b} || $::a <=> $::b} @{$a}];
}
