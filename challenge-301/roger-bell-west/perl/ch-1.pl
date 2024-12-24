#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(largestnumber([20, 3]), 320, 'example 1');
is(largestnumber([3, 30, 34, 5, 9]), 9534330, 'example 2');

sub largestnumber($c) {
  my @b = reverse sort {
    return "$a$b" cmp "$b$a";
  } @{$c};
  0 + join('', @b);
}
