#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(equalgroup([1, 1, 2, 2, 2, 2]), 1, 'example 1');
is(equalgroup([1, 1, 1, 2, 2, 2, 3, 3]), 0, 'example 2');
is(equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]), 1, 'example 3');
is(equalgroup([1, 2, 3, 4]), 0, 'example 4');
is(equalgroup([8, 8, 9, 9, 10, 10, 11, 11]), 1, 'example 5');

use List::Util qw(all);
use List::MoreUtils qw(uniq);

sub equalgroup($a) {
  my %s;
  map {$s{$_}++} @{$a};
  my @v = sort {$::a <=> $::b} uniq values %s;
  my $l = $v[0];
  if ($l < 2) {
    return 0;
  }
  foreach my $t (2 .. $l) {
    if (all {$_ % $t == 0} @v) {
      return 1;
    }
  }
  0;
}
