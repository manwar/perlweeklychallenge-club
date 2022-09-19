#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

use Storable qw(freeze);

is_deeply(uniquearray([[1,2], [3,4], [5,6], [1,2]]),
          [[1,2], [3,4], [5,6]],
          'example 1');
is_deeply(uniquearray([[9,1], [3,7], [2,5], [2,5]]),
          [[9,1], [3,7], [2,5]],
          'example 2');

sub uniquearray($n) {
  my @o;
  my %oh;
  foreach my $i (@{$n}) {
    my $ti = freeze($i);
    if (!exists $oh{$ti}) {
      push @o,$i;
      $oh{$ti} = 1;
    }
  }
  return \@o;
}
