#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(largestsubstring('aaaaa'), 3, 'example 1');
is(largestsubstring('abcdeba'), 5, 'example 2');
is(largestsubstring('abbc'), 0, 'example 3');
is(largestsubstring('abcaacbc'), 4, 'example 4');
is(largestsubstring('laptop'), 2, 'example 5');

sub largestsubstring($a) {
  my @cc = split '',$a;
  foreach my $offset (reverse(1 .. $#cc)) {
    foreach my $x (0 .. $#cc - $offset) {
      if ($cc[$x] eq $cc[$x + $offset]) {
        return $offset - 1;
      }
    }
  }
  -1;
}
