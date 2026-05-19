#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(equallist(['a', 'bc'], ['ab', 'c']), 1, 'example 1');
is(equallist(['a', 'b', 'c'], ['a', 'bc']), 1, 'example 2');
is(equallist(['a', 'bc'], ['a', 'c', 'b']), 0, 'example 3');
is(equallist(['ab', 'c', ''], ['', 'a', 'bc']), 1, 'example 4');
is(equallist(['p', 'e', 'r', 'l'], ['perl']), 1, 'example 5');

sub equallist($a, $b) {
  (join("", @{$a}) eq join("", @{$b}))?1:0;
}
