#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(countprefixes(['a', 'ap', 'app', 'apple', 'banana'], 'apple'), 4, 'example 1');
is(countprefixes(['cat', 'dog', 'fish'], 'bird'), 0, 'example 2');
is(countprefixes(['hello', 'he', 'hell', 'heaven', 'he'], 'hello'), 4, 'example 3');
is(countprefixes(['', 'code', 'coding', 'cod'], 'coding'), 3, 'example 4');
is(countprefixes(['p', 'pr', 'pro', 'prog', 'progr', 'progra', 'program'], 'program'), 7, 'example 5');

sub countprefixes($a, $b) {
  scalar grep {index($b, $_) == 0} @{$a};
}
