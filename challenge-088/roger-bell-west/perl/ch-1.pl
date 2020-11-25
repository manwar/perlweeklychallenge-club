#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(aop([5, 2, 1, 4, 3]),[24, 60, 120, 30, 40],'example 1');
is_deeply(aop([2, 1, 4, 3]),[12, 24, 6, 8],'example 2');

use List::Util qw(product);
use integer;

sub aop {
  my $ns=shift;
  my $p=product(@{$ns});
  return [map {$p/$_} @{$ns}];
}
