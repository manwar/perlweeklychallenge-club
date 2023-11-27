#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is(grouphero([2, 1, 4]), 141, 'example 1');

use Algorithm::Combinatorics qw(combinations);

sub grouphero($nums0) {
  my @nums = sort {$a <=> $b} @{$nums0};
  my $sum = 0;
  foreach my $l (1 .. scalar @nums) {
    foreach my $c (combinations(\@nums, $l)) {
      $sum += $c->[-1] * $c->[-1] * $c->[0];
    }
  }
  return $sum;
}
