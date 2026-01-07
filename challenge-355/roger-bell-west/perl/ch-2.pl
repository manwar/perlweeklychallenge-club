#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(mountainarray([1, 2, 3, 4, 5]), 0, 'example 1');
is(mountainarray([0, 2, 4, 6, 4, 2, 0]), 1, 'example 2');
is(mountainarray([5, 4, 3, 2, 1]), 0, 'example 3');
is(mountainarray([1, 3, 5, 5, 4, 2]), 0, 'example 4');
is(mountainarray([1, 3, 2]), 1, 'example 5');

use List::MoreUtils qw(slide);

sub mountainarray($a) {
  my $state = 0;
  my $valid = 1;
  slide {
    if ($::b > $::a) {
      if ($state == 0 || $state == 1) {
        $state = 1;
      } else {
        $valid = 0;
      }
    } elsif ($::b < $::a) {
      if ($state == 1 || $state == 2) {
        $state = 2;
      } else {
        $valid = 0;
      }
    } else {
      $valid = 0;
    }
  } @{$a};
  ($valid && $state == 2)?1:0;
}
