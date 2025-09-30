#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(duplicateremovals('abbaca'), 'ca', 'example 1');
is(duplicateremovals('azxxzy'), 'ay', 'example 2');
is(duplicateremovals('aaaaaaaa'), '', 'example 3');
is(duplicateremovals('aabccba'), 'a', 'example 4');
is(duplicateremovals('abcddcba'), '', 'example 5');

sub duplicateremovals($a) {
  my @b;
  foreach my $c (split '', $a) {
    if (scalar @b == 0 || $c ne $b[-1]) {
      push @b, $c;
    } else {
      pop @b;
    }
  }
  join('', @b);
}
