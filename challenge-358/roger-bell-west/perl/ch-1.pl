#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxstrvalue(['123', '45', '6']), 123, 'example 1');
is(maxstrvalue(['abc', 'de', 'fghi']), 4, 'example 2');
is(maxstrvalue(['0012', '99', 'a1b2c']), 99, 'example 3');
is(maxstrvalue(['x', '10', 'xyz', '007']), 10, 'example 4');
is(maxstrvalue(['hello123', '2026', 'perl']), 2026, 'example 5');

use List::Util qw(max);

sub strvalue($a) {
  if ($a =~ /^[0-9]+$/) {
    return 0 + $a;
  }
  length($a);
}

sub maxstrvalue($a) {
  max(map {strvalue($_)} @{$a});
}
