#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(consistentstrings(['ad', 'bd', 'aaab', 'baa', 'badab'], 'ab'), 2, 'example 1');
is(consistentstrings(['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'], 'ab'), 3, 'example 2');
is(consistentstrings(['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'], 'cad'), 4, 'example 3');

use List::Util qw(uniqstr all);

sub consistentstrings($a, $v) {
  my %vs = map {$_ => 1} uniqstr(split '',$v);
  return scalar grep {all {exists $vs{$_}} split '',$_} @{$a};
}
