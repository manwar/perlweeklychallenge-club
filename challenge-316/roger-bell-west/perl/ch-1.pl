#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(circular(['perl', 'loves', 'scala']), 1, 'example 1');
is(circular(['love', 'the', 'programming']), 0, 'example 2');
is(circular(['java', 'awk', 'kotlin', 'node.js']), 1, 'example 3');

use List::MoreUtils qw(slideatatime);

sub circular($a) {
  my $dd = slideatatime(1, 2, @{$a});
  while (my @p = $dd->()) {
    if (scalar @p == 2) {
      if (substr($p[0], -1, 1) ne substr($p[1], 0, 1)) {
        return 0;
      }
    }
  }
  1;
}
