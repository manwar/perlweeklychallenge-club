#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(firstunique("Perl Weekly Challenge"),0,'example 1');

is(firstunique("Long Live Perl"),1,'example 2');

is(firstunique("aabbcc"),-1,'example 3');

sub firstunique($s) {
  my @s = split '',$s;
  my %cc;
  map {$cc{$_}++} @s;
  foreach my $i (0..$#s) {
    if ($cc{$s[$i]} == 1) {
      return $i;
    }
  }
  return -1;
}
