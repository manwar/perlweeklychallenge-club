#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(sumbitwise([1,2,3]),3,'example 1');
is(sumbitwise([2,3,4]),2,'example 2');

use Algorithm::Combinatorics qw(combinations);

sub sumbitwise {
  my $ls = shift;
  my $iter = combinations($ls,2);
  my $s = 0;
  while (my $c = $iter->next) {
    $s += $c->[0] & $c->[1];
  }
  return $s;
}
