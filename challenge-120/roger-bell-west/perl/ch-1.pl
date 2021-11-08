#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(seob(101),154,'example 1');
is(seob(18),33,'example 2');

sub seob {
  my $n=shift;
  return (($n & 0x55)<<1) | (($n & 0xAA)>>1);
}
