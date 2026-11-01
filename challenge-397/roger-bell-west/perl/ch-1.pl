#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(absentsmallestpositive([1, 2, 4, 5, 6]), 7, 'example 1');
is(absentsmallestpositive([-5, -2, -1, 3]), 1, 'example 2');
is(absentsmallestpositive([1, 2, 3]), 4, 'example 3');
is(absentsmallestpositive([2, 3, 7, 8]), 6, 'example 4');
is(absentsmallestpositive([1, 1, 1, 10]), 4, 'example 5');

use List::Util qw(sum);

sub absentsmallestpositive($a) {
  my $tot = sum(@{$a});
  my %ex = map {$_ => 1} @{$a};
  my $mul = scalar @{$a};
  my $n = 1;
  while (1) {
    if ($n * $mul > $tot && !exists $ex{$n}) {
      return $n;
    }
    $n++;
  }
  0;
}
