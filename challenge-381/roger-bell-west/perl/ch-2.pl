#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(smallergreaterelement([2, 4]), 0, 'example 1');
is(smallergreaterelement([1, 1, 1, 1]), 0, 'example 2');
is(smallergreaterelement([1, 1, 4, 8, 12, 12]), 2, 'example 3');
is(smallergreaterelement([3, 6, 6, 9]), 2, 'example 4');
is(smallergreaterelement([0, -5, 10, -2, 4]), 3, 'example 5');

use List::MoreUtils qw(minmax);

sub smallergreaterelement($a) {
  my @mm = minmax(@{$a});
  scalar grep {$_ > $mm[0] && $_ < $mm[1]} @{$a};
}
