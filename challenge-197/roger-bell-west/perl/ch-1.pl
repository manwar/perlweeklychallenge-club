#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(movezero([1, 0, 3, 0, 0, 5]), [1, 3, 5, 0, 0, 0], 'example 1');
is_deeply(movezero([1, 6, 4]), [1, 6, 4], 'example 2');
is_deeply(movezero([0, 1, 0, 2, 0]), [1, 2, 0, 0, 0], 'example 3');

sub movezero($l) {
  my @o = grep {$_ != 0} @{$l};
  push @o,(0) x (scalar (@{$l}) - scalar (@o));
  return \@o;
}
