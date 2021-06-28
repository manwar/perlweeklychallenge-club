#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(sw(5),13,'example 1');
is(sw(10),32,'example 2');
is(sw(60),2223,'example 3');

sub sw {
  my $c=shift;
  my $n=0;
  while ($c) {
    $n++;
    if ($n =~ /[04-9]/ || $n =~ /11/) {
      next;
    }
    $c--;
  }
  return $n;
}
