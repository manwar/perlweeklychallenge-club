#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is_deeply(pattern132([3, 1, 4, 2]), [1, 4, 2], 'example 1');
is_deeply(pattern132([1, 2, 3, 4]), [], 'example 2');
is_deeply(pattern132([1, 3, 2, 4, 6, 5]), [1, 3, 2], 'example 3');
is_deeply(pattern132([1, 3, 4, 2]), [1, 3, 2], 'example 4');

sub pattern132($l) {
  my $o = [];
 OUTER:
  foreach my $a (0..$#{$l}-2) {
    foreach my $b ($a+1..$#{$l}-1) {
      if ($l->[$a] < $l->[$b]) {
        foreach my $c ($b+1..$#{$l}) {
          if ($l->[$b] > $l->[$c] && $l->[$a] < $l->[$c]) {
            $o = [$l->[$a], $l->[$b], $l->[$c]];
            last OUTER;
          }
        }
      }
    }
  }
  return $o;
}
