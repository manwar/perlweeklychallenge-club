#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(singlecommonword(['apple', 'banana', 'cherry'], ['banana', 'cherry', 'date']), 2, 'example 1');
is(singlecommonword(['a', 'ab', 'abc'], ['a', 'a', 'ab', 'abc']), 2, 'example 2');
is(singlecommonword(['orange', 'lemon'], ['grape', 'melon']), 0, 'example 3');
is(singlecommonword(['test', 'test', 'demo'], ['test', 'demo', 'demo']), 0, 'example 4');
is(singlecommonword(['Hello', 'world'], ['hello', 'world']), 1, 'example 5');

sub singlecommonword($a, $b) {
  my %ac;
  map {$ac{$_} += 1} @{$a};
  my %bc;
  map {$bc{$_} += 1} @{$b};
  my $total = 0;
  while (my ($w, $ca) = each %ac) {
    if ($ca == 1 && exists $bc{$w} && $bc{$w} == 1) {
      $total += 1;
    }
  }
  $total;
}
