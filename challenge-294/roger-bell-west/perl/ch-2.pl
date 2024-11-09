#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(nextpermutation([1, 2, 3]), [1, 3, 2], 'example 1');
is_deeply(nextpermutation([2, 1, 3]), [2, 3, 1], 'example 2');
is_deeply(nextpermutation([3, 1, 2]), [3, 2, 1], 'example 3');

use Algorithm::Combinatorics qw(permutations);
use Array::Compare;

sub nextpermutation($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my $flag = 0;
  my @out;
  my $comp = Array::Compare->new;
  my $ip = permutations(\@b);
  while (my $px = $ip->next) {
    if (scalar @out == 0) {
      @out = @{$px};
    }
    if ($flag) {
      @out = @{$px};
      last;
    }
    if ($comp->compare($px, $a)) {
      $flag = 1;
    }
  }
  \@out;
}
