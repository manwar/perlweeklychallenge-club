#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(sn(101),86,'example 1');
is(sn(18),33,'example 2');

sub sn {
  my $n=shift;
  return 16*($n % 16)+int($n/16);
}
