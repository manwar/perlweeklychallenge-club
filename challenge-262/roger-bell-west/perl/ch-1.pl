#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maxpositivenumber([-3, 1, 2, -1, 3, -2, 4]), 4, 'example 1');
is(maxpositivenumber([-1, -2, -3, 1]), 3, 'example 2');
is(maxpositivenumber([1, 2]), 2, 'example 3');

use List::Util qw(max);

sub maxpositivenumber($a) {
  return max(
    (scalar grep {$_ > 0} @{$a}),
    (scalar grep {$_ < 0} @{$a}),
      );
}
