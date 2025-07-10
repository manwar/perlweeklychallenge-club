#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(counterintegers('the1weekly2challenge2'), [1, 2], 'example 1');
is_deeply(counterintegers('go21od1lu5c7k'), [21, 1, 5, 7], 'example 2');
is_deeply(counterintegers('4p3e2r1l'), [4, 3, 2, 1], 'example 3');

sub counterintegers($a) {
  my @numbers = grep /./, split /\D+/, $a;
  my $i = 0;
  my %seen;
  while ($i < scalar @numbers) {
    if (exists $seen{$numbers[$i]}) {
      splice @numbers, $i, 1;
    } else {
      $seen{$numbers[$i]} = 1;
      $i++;
    }
  }
  \@numbers;
}
