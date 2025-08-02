#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(distinctaverage([1, 2, 4, 3, 5, 6]), 1, 'example 1');
is(distinctaverage([0, 2, 4, 8, 3, 5]), 2, 'example 2');
is(distinctaverage([7, 3, 1, 0, 5, 9]), 2, 'example 3');

sub distinctaverage($a0) {
  my @a = sort { $::a <=> $::b }  @{$a0};
  my $offset = scalar @a - 1;
  my %res;
  foreach my $i (0 .. (scalar @a) / 2) {
    $res{$a[$i] + $a[$offset - $i]} = 1;
  }
  scalar keys %res;
}
