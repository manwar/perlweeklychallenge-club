#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(baftera('aabb'), 1, 'example 1');
is(baftera('abab'), 0, 'example 2');
is(baftera('aaa'), 0, 'example 3');
is(baftera('bbb'), 1, 'example 4');

sub baftera($a) {
  my $firstb = index($a, "b");
  if ($firstb == -1) {
    return 0;
  }
  my $lasta = rindex($a, "a");
  if ($lasta == -1) {
    return 1;
  }
  return ($lasta < $firstb)?1:0;
}
