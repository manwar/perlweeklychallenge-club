#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(ib(12,3),8,'example 1');
is(ib(18,4),26,'example 2');

sub ib {
  my ($m,$n)=@_;
  return $m ^ (1 << ($n-1));
}
