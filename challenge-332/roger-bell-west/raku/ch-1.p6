#! /usr/bin/raku

use Test;

plan 3;

is(binarydate('2025-07-26'), '11111101001-111-11010', 'example 1');
is(binarydate('2000-02-02'), '11111010000-10-10', 'example 2');
is(binarydate('2024-12-31'), '11111101000-1100-11111', 'example 3');

sub binarydate($a) {
  $a.split('-').map({sprintf('%b', $_)}).join('-');
}
