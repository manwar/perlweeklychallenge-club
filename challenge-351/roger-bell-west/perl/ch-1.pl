#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(specialaverage([8000, 5000, 6000, 2000, 3000, 7000]), 5250, 'example 1');
is(specialaverage([100000, 80000, 110000, 90000]), 95000, 'example 2');
is(specialaverage([2500, 2500, 2500, 2500]), 0, 'example 3');
is(specialaverage([2000]), 0, 'example 4');
is(specialaverage([1000, 2000, 3000, 4000, 5000, 6000]), 3500, 'example 5');

use List::Util qw(sum);

sub specialaverage($a) {
  my @a = sort {$::a <=> $::b} @{$a};
  my $min = $a[0];
  my $max = $a[-1];
  my @b = grep {$_ != $min && $_ != $max} @a;
  if (scalar @b == 0) {
    return 0;
  }
  sum(@b) / (scalar @b);
}
