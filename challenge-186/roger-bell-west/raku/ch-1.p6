#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(ziplist(["1", "2", "3"], ["a", "b", "c"]),
          ["1", "a", "2", "b", "3", "c"],
          'example 1');

sub ziplist(@a, @b) {
  return Array(zip(@a,@b)[*;*]);
}
