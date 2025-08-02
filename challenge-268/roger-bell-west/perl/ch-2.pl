#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(numbergame([2, 5, 3, 4]), [3, 2, 5, 4], 'example 1');
is_deeply(numbergame([9, 4, 1, 3, 6, 4, 6, 1]), [1, 1, 4, 3, 6, 4, 9, 6], 'example 2');
is_deeply(numbergame([1, 2, 2, 3]), [2, 1, 3, 2], 'example 3');

use List::Util qw(pairs);

sub numbergame($a0) {
  my @out;
  my @a = sort {$::a <=> $::b }@{$a0};
  foreach my $p (pairs @a) {
    push @out, $p->[1];
    push @out, $p->[0];
  }
  return \@out;
}
