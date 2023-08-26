#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(notminmax([3, 2, 1, 4]), [3, 2], 'example 1');
is_deeply(notminmax([3, 1]), [], 'example 2');
is_deeply(notminmax([2, 1, 3]), [2], 'example 3');

use List::MoreUtils qw(minmax);

sub notminmax($a) {
  my @mm = minmax(@{$a});
  return [grep {$_ > $mm[0] && $_ < $mm[1]} @{$a}];
}
